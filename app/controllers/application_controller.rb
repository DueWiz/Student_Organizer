class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :init

  helper_method :user_groups, :time_due

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

  def init
      @homework = Homework.new
      @latte = LatteAccount.new
  end
end
