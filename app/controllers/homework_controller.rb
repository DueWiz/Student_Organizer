class HomeworkController < ApplicationController
  before_action :authenticate_user!

  def index
    # @hws = Hash.new
    # my_hw = UserHomework.where("user_id = ?", current_user.id)
    # if my_hw != nil
    #   my_hw.each do |hw|
    #     temp = Homework.find_by_id(hw.homework_id)
    #     seconds = ((temp.due_date - DateTime.now)-3600).to_i
    #     sec = seconds % 60
    #     minutes = seconds / 60
    #     min = minutes % 60
    #     hours = minutes / 60
    #     hour = hours % 24
    #     days = hours / 24
    #     timeLeft = days.to_s + 'Days, ' + hour.to_s + 'Hours, '+ min.to_s + 'Mins'
    #     @hws[hw.homework_id] = [temp, hw, timeLeft]
    #   end
    # end
    params[:hw_choice] == "Uncompleted"
    hwstatus = current_user.user_homeworks.where(status: 'No attempt')
    myhwArray = Array.new
    hwstatus.each do |h|
      myhwArray.push(h.homework_id)
    end
    @my_hw = current_user.homeworks.where(id: myhwArray).order(:due_date)
    @table = Array.new
    @date_infos = Array.new
    index = 0
    count = 0
    @my_hw.each do |hw|
      if count == 0
        @table[index] = Array.new
        @date_infos[index] = Array.new
      end
      @table[index] += [hw]
      @date_infos[index] += [display_date_info(hw,'No attempt')]
      count += 1
      if count == 3
        index += 1
        count = 0
      end
    end
    @homeworks = Homework.all
  end

  def result
    @my_hw = current_user.homeworks.order(:due_date)
    if params[:hw_choice] == "All"
      @my_hw = current_user.homeworks.order(:due_date)
    elsif params[:hw_choice] == "Uncompleted"
      # @my_hw = @my_hw.where("due_date > ?", DateTime.now)
      hwstatus = current_user.user_homeworks.where(status: 'No attempt')
      myhwArray = Array.new
      hwstatus.each do |h|
        myhwArray.push(h.homework_id)
      end
      @my_hw = @my_hw.where(id: myhwArray)
    elsif params[:hw_choice] == "Completed"
      # @my_hw = @my_hw.where("due_date < ?", DateTime.now)
      hwstatus = current_user.user_homeworks.where(status: 'Submitted for grading')
      myhwArray = Array.new
      hwstatus.each do |h|
        myhwArray.push(h.homework_id)
      end
      @my_hw = @my_hw.where(id: myhwArray)
    end
    if not params[:search].nil?
      @my_hw = @my_hw.where("name LIKE ?", "%#{params[:search]}%")
    end
    @table = Array.new
    @date_infos = Array.new
    index = 0
    count = 0
    @my_hw.each do |hw|
      if count == 0
        @table[index] = Array.new
        @date_infos[index] = Array.new
      end
      @table[index] += [hw]
      status = current_user.user_homeworks.find_by_homework_id(hw.id).status
      @date_infos[index] += [display_date_info(hw,status)]
      count += 1
      if count == 3
        index += 1
        count = 0
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def new
  end

  def edit
    myhw = current_user.user_homeworks.find_by_homework_id(params[:id])
    myhw.status = params[:homework][:status]
    myhw.note = params[:homework][:note]
    homework = Homework.find_by_id(params[:id])
    homework.name = params[:homework][:name]
    homework.due_date = Time.zone.local(params[:homework]["due_date(1i)"].to_i,
                                 params[:homework]["due_date(2i)"].to_i,
                                 params[:homework]["due_date(3i)"].to_i,
                                 params[:homework]["due_date(4i)"].to_i,
                                 params[:homework]["due_date(5i)"].to_i,)
    homework.description = params[:homework][:description]
    thisGroup = Group.find_by_id(params[:group])
    if thisGroup != nil
      homework.group_id = thisGroup.id
    end
    homework.save!
    myhw.save!
    redirect_to homeworkshow_path
  end

  def create
    @new = Homework.new
    @new.name = params[:homework][:name]
    @new.due_date = Time.zone.local(params[:homework]["due_date(1i)"].to_i,
                                 params[:homework]["due_date(2i)"].to_i,
                                 params[:homework]["due_date(3i)"].to_i,
                                 params[:homework]["due_date(4i)"].to_i,
                                 params[:homework]["due_date(5i)"].to_i,)
    @new.description = params[:homework][:description]
    thisGroup = Group.find_by_id(params[:group])
    if thisGroup != nil
      @new.group_id = thisGroup.id
    end
    @new.save!
    UserHomework.create(user_id: current_user.id, homework_id: @new.id, admin: true, status: 'No attempt')
    redirect_to homework_url
  end

  def show
    @this_hw = Homework.find_by_id(params[:id])
    @due = time_due(@this_hw.due_date)
    @this_userhw = current_user.user_homeworks.find_by_homework_id(params[:id])
    this_group = Group.find_by_id(@this_hw.group_id)
    if this_group != nil
      @groupName = this_group.year.to_s + "-" + this_group.term + "-"+ this_group.name + "-Section " + this_group.section.to_s
    else
      @groupName = "My Own Homeworks"
    end
  end

  def update
    @homework = Homework.find_by_id(params[:id])
  end

  def destroy
    UserHomework.find_by_homework_id_and_user_id(params[:id],current_user.id).destroy
    redirect_to homework_url
  end
end
