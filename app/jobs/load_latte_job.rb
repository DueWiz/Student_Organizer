class LoadLatteJob < ApplicationJob
  queue_as :default

  TERM = {"1"=>"Spring","2"=>"Summer","3"=>"Fall"}

  def create_group(link_text,current_user)
      course_abbr = link_text.split(':')[0]
      course_abbr.strip!
      course_year = "20#{course_abbr[0..1]}".to_i
      course_term = TERM[course_abbr[2]]
      course_section = course_abbr[-1].to_i
      group = Group.new
      group.name = course_abbr[3..-3]
      group.term = course_term
      group.year = course_year
      group.section = course_section
      group.save
      group_user = GroupUser.new
      group_user.user_id = current_user.id
      group_user.group_id = group.id
      group_user.save
      return group.id
  end

  def perform(current_user)
    agent = Mechanize.new
    agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    logger.info "Latte Account Name:#{current_user.latte_account.name}"
    logger.info "Latte Account password:#{current_user.latte_account.password}\n\n\n\n\n\n\n\n\n"
    ActionCable.server.broadcast "latte_info_#{current_user.id}", spin_status: 'active'
    ActionCable.server.broadcast "latte_info_#{current_user.id}", bar_status: 'Initialized'
    ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: 'Initialized'
    page = agent.get('https://login.brandeis.edu/?factors=BRANDEIS.EDU,ldapauth&cosign-moodle2-prod&https://moodle2.brandeis.edu/')
    form = page.form('f')
    form.field_with(:id => "login").value = current_user.latte_account.name
    form.field_with(:id => "password").value = current_user.latte_account.password
    page = agent.submit(form, form.buttons_with(:type => /submit/)[0])
    ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: 'Logged in'
    ActionCable.server.broadcast "latte_info_#{current_user.id}", bar_status: 'Logged in'

    hw_count = 0
    group_id = nil
    page.links_with(css: "a.course_show").each do |link|
      if link.text =~ /^161/
        course_page = link.click
        course_page.links_with(css: "li.assign div.activityinstance a").each do |a_link|
          hw_count += 1
        end
      end
    end
    hw_count2 = 0
    ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: "Expect to load #{hw_count} items."
    ActionCable.server.broadcast "latte_info_#{current_user.id}", bar_status: 'Loading'
    ActionCable.server.broadcast "latte_info_#{current_user.id}", progress: "#{hw_count2}/#{hw_count} items"
    page.links_with(css: "a.course_show").each do |link|
      if link.text =~ /^161/
        group_id = create_group(link.text,current_user)
        course_page = link.click
        course_page.links_with(css: "li.assign div.activityinstance a").each do |a_link|
          hw_count2 += 1
          assignment_page = a_link.click
          #Create HW
          h = Homework.new

          #link group_id
          h.group_id = group_id

          #Associations with User
          u_h = UserHomework.new
          u_h.user_id = current_user.id

          ActionCable.server.broadcast "latte_info_#{current_user.id}", spin_status: 'active'
          ActionCable.server.broadcast "latte_info_#{current_user.id}", bar_status: 'Loading'
          ActionCable.server.broadcast "latte_info_#{current_user.id}", progress: "#{hw_count2}/#{hw_count} items"
          #Homework stats
          ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: "Now loading #{hw_count2}/#{hw_count} items."
          a_title = assignment_page.xpath("//div[@role='main']/h2/text()")
          h.name = a_title.to_s
          ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: "#{a_title}"
          a_sub_status = assignment_page.xpath("//td[contains(., 'Submission status')]/following-sibling::td/text()")
          u_h.status = a_sub_status.to_s
          ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: "#{a_sub_status}"
          a_due_date = assignment_page.xpath("//td[contains(., 'Due date')]/following-sibling::td/text()")
          unless a_due_date.to_s == ""
            estHoursOffset = -5
            estOffset = Rational(estHoursOffset, 24)
            h.due_date = (DateTime.parse(a_due_date.to_s) - (estHoursOffset/24.0)).new_offset(estOffset)
          end
          ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: "#{a_due_date}"
          h.save
          u_h.homework_id = h.id
          u_h.save
          ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: "Finished current assignment page"
        end
      end
    end
    ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: '<br/><a href="/">Back</a>'
    ActionCable.server.broadcast "latte_info_#{current_user.id}", spin_status: 'inactive'
    ActionCable.server.broadcast "latte_info_#{current_user.id}", bar_status: "Finished"
  end
end
