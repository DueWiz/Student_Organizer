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
    @my_hw = current_user.homeworks.order(:due_date)
    @table = Array.new
    index = 0
    count = 0
    @my_hw.each do |hw|
      if count == 0
        @table[index] = Array.new
      end
      @table[index] += [hw]
      count += 1
      if count == 3
        index += 1
        count = 0
      end
    end
  end

  def new
  end

  def edit
    homework = Homework.find_by_id(params[:id])
    homework.name = params[:homework][:name]
    Time.zone = 'EST'
    homework.due_date = Time.zone.local(params[:homework]["due_date(1i)"].to_i,
                                 params[:homework]["due_date(2i)"].to_i,
                                 params[:homework]["due_date(3i)"].to_i,
                                 params[:homework]["due_date(4i)"].to_i,
                                 params[:homework]["due_date(5i)"].to_i,)
    homework.description = params[:homework][:description]
    homework.save!
    redirect_to homeworkshow_path
  end

  def create
    @new = Homework.new
    @new.name = params[:homework][:name]
    Time.zone = 'EST'
    @new.due_date = Time.zone.local(params[:homework]["due_date(1i)"].to_i,
                                 params[:homework]["due_date(2i)"].to_i,
                                 params[:homework]["due_date(3i)"].to_i,
                                 params[:homework]["due_date(4i)"].to_i,
                                 params[:homework]["due_date(5i)"].to_i,)
    @new.description = params[:homework][:description]
    @new.save!
    UserHomework.create(user_id: current_user.id, homework_id: @new.id, admin: true)
    redirect_to homework_url
  end

  def show
    @this_hw = Homework.find_by_id(params[:id])
    @this_userhw = current_user.user_homeworks.find_by_homework_id(params[:id])
  end

  def update
    @homework = Homework.find_by_id(params[:id])
  end

  def destroy
  end
end
