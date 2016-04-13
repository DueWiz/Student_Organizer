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

  def join
      newGroup = UserGroup.create(user_id: current_user.id, group_id: params[:id])
      newGroup.save!
      Homework.where(group_id: params[:id]).find_each do |hw|


      end

  end

  def search
    logger.info "test for search"
    @result = Group.where(['name LIKE ?', "%#{params[:group][:name]}%"]).all.order(:name, :term, :year, :section)

  end

  def show
    @group = Group.find_by_id(params[:id])
  end

  def create
    groupCheck = Group.find_by_name_and_year_and_term_and_section(params[:group][:name],params[:group][:year],params[:group][:term],params[:group][:section])
    if groupCheck == nil
      @new = Group.create(name: params[:group][:name].capitalize, year: params[:group][:year], term: params[:group][:term], section: params[:group][:section])
      @new.save!
      GroupUser.create(user_id: current_user.id, group_id: @new.id, admin: true)
      redirect_to homework_url
    else
      @groupName = params[:group][:name]
    end
  end

end
