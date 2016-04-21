class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :init

  helper_method :user_groups, :time_due, :display_date_info

  def user_groups
    if user_signed_in?
      current_user.groups
    else
      []
    end
  end

  def has_latte?
      current_user.latte_account.present?
  end

  def time_due(due_date)
      seconds = ((due_date - DateTime.now)).to_i
      sec = seconds % 60
      minutes = seconds / 60
      min = minutes % 60
      hours = minutes / 60
      hour = hours % 24
      days = hours / 24
      if seconds >= 0
        duedata = [days,hour,min]
      else
        duedate = [days, 23-hour, 60-min]
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
      if time_remain[0] <= 0  #finish
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


  def init
      @homework = Homework.new
      @latte = LatteAccount.new
  end
end
