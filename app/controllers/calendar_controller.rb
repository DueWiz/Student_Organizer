class CalendarController < ApplicationController
  def index
    @homeworks = getMyHw
  end
end
