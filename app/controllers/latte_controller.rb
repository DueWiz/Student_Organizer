require 'mechanize'
class LatteController < ApplicationController
    def create
        @latte = LatteAccount.new
        @latte.name = params["latte_account"]["name"]
        @latte.password = params["latte_account"]["password"]
        logger.info "Post password::: #{params['latte_account']['password']}"
        @latte.user_id = params["user_id"]
        respond_to do |format|
            if @latte.save
                format.html { redirect_to latte_info_path, task: 'refresh_latte' }
                format.json { render json: @latte, status: :created, location: @latte }
                format.js
            else
                format.html { redirect_to homework_index_path, notice: 'latte not completed.' }
                format.json { render json: @latte.errors, status: :unprocessable_entity }
                format.js { render file: "/app/views/latte/fail"}
            end
        end
    end

    def destroy
      current_user.latte_account.destroy
      respond_to do |format|
         format.js { render file: "/app/views/latte/destroy"}
      end
    end

    def info

      ActionCable.server.broadcast "latte_info_#{current_user.id}",
        latte_info: 'good'
      agent = Mechanize.new
      agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      logger.info "Latte Account Name:#{current_user.latte_account.name}"
      logger.info "Latte Account password:#{current_user.latte_account.password}\n\n\n\n\n\n\n\n\n"
      ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: 'Initialized'
      page = agent.get('https://login.brandeis.edu/?factors=BRANDEIS.EDU,ldapauth&cosign-moodle2-prod&https://moodle2.brandeis.edu/')
      form = page.form('f')
      form.field_with(:id => "login").value = current_user.latte_account.name
      form.field_with(:id => "password").value = current_user.latte_account.password
      page = agent.submit(form, form.buttons_with(:type => /submit/)[0])
      ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: 'Logged in'
      logger.info "This is a logger info"
      logger.info ENV["SECRET_KEY_BASE"]
      page.links_with(css: "a.course_show").each { |link|
    if link.text =~ /^161/
        course_page = link.click
        course_page.links_with(css: "li.assign div.activityinstance a").each { |a_link|
          assignment_page = a_link.click
          ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: assignment_page.xpath("//div[@role='main']/h2/text()")
          ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: assignment_page.xpath("//td[contains(., 'Submission status')]/following-sibling::td/text()")
          ActionCable.server.broadcast "latte_info_#{current_user.id}", latte_info: assignment_page.xpath("//td[contains(., 'Due date')]/following-sibling::td/text()")
        }
        # file = File.open("course_page#{count}.html", "w")
        # file.write(course_page.content)
        # count += 1
    end
}
    end
end
