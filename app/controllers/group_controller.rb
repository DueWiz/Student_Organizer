class GroupController < ApplicationController
  before_action :authenticate_user!
  def index
    @my_groups = current_user.groups
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
