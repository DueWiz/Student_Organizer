class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, :init

  helper_method :user_groups

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

  def init
      @homework = Homework.new
      @latte = LatteAccount.new
  end
end
