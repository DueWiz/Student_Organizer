class HomeworkController < ApplicationController
  def index
    @my_hw = Homework.joins(:user_homeworks).find(user_id: :user_id).order(due_date: :asc)

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
