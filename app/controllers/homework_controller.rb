class HomeworkController < ApplicationController
  before_action :authenticate_user!
  def index
    @hws = Hash.new
    my_hw = UserHomework.find_by_id(current_user.id)
    if my_hw != nil
      my_hw.each do |hw|
        @hws[hw.homework_id] = [Homework.find_by_id(hw.homework_id), hw]
      end
    end
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
