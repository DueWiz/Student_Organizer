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
  def create
    @new = Group.create(name: params[:group][:name])
    @new.save!
    GroupUser.create(user_id: current_user.id, group_id: @new.id)
    redirect_to homework_url
  end

end
