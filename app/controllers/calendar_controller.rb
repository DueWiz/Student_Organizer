class CalendarController < ApplicationController
  def index
  	@homeworks = Homework.all
  end
end
