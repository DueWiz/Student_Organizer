class CalendarController < ApplicationController
  def index
  	myhomework = current_user.user_homeworks
    myhwArray = Array.new
    myhomework.each do |hw|
      myhwArray.push(hw.homework_id)
    end
    @homeworks = Homework.where(id: myhwArray)
  end
end
