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
    @my_hw = current_user.homeworks.order(:due_date)
    @my_hw = @my_hw.where("due_date > ?", DateTime.now)
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
      @date_infos[index] += [display_date_info(hw)]
      count += 1
      if count == 3
        index += 1
        count = 0
      end
    end
  end

  def result
    @my_hw = current_user.homeworks.order(:due_date)
    if params[:hw_choice] == "All"
      @my_hw = current_user.homeworks.order(:due_date)
    elsif params[:hw_choice] == "Uncompleted"
      @my_hw = @my_hw.where("due_date > ?", DateTime.now)
    elsif params[:hw_choice] == "Completed"
      @my_hw = @my_hw.where("due_date < ?", DateTime.now)
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
      @date_infos[index] += [display_date_info(hw)]
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

  def display_date_info (hw)
    time_remain = time_due(hw.due_date)
    if time_remain[0] == 0 and time_remain[1]>=0 and time_remain[2]>=0
      if time_remain[1] == 0 # min
        num = time_remain[2]
        card_class = "danger"
        time_info = "Mins"
      else
        num = time_remain[1] #hour
        card_class = "warning"
        time_info = "Hours"
      end
    else
      if time_remain[0] <= 0 or (time_remain[1] <= 0 and time_remain[0] == 0) or (time_remain[1] == 0 and time_remain[2] <= 0 and time_remain[0] == 0) #finish
        num = 0
        card_class = "success"
        time_info = "Done"
      else
        num = time_remain[0]
        time_info = "Days"
        if time_remain[0] < 7
          card_class = "info"
        else
          card_class = "primary"
        end
      end
    end
    date_info = [card_class, num, time_info]
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
    @due = time_due(@this_hw.due_date)
    @this_userhw = current_user.user_homeworks.find_by_homework_id(params[:id])
  end

  def update
    @homework = Homework.find_by_id(params[:id])
  end

  def destroy
  end
end
