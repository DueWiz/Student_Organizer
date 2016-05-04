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
    deletion = Homework.where(group_id: params[:id])
    deletion.find_each do |hw|
      UserHomework.find_by_homework_id(hw.id).destroy
    end
    GroupUser.find_by_user_id_and_group_id(current_user.id,params[:id]).destroy
    redirect_to homework_url
  end

  def join
      @group = Group.find(params[:group_id])
      authorize @group
      newGroup = GroupUser.create(user_id: current_user.id, group_id: params[:group_id], membership: "member")
      Homework.where(group_id: params[:group_id]).find_each do |hw|
        UserHomework.create(user_id: current_user.id, homework_id: hw.id, admin: true)
      end
      redirect_to groupshow_path(params[:group_id])
  end

  def search
    @result = Group.where(['name LIKE ?', "%#{params[:name]}%"]).all.order(:name, :term, :year, :section)
    @relation = GroupUser.all
  end

  def show
    if params[:id] == "-1"
      myhws = getMyHw
      hws = myhws.where(group_id: nil).order(:due_date)
    else
      @group = Group.find_by_id(params[:id])
      hws = Homework.where('group_id = ?', @group.id).order(:due_date)
    end
    @table = Array.new
    @date_infos = Array.new
    index = 0
    count = 0
    hws.each do |hw|
      if count == 0
        @table[index] = Array.new
        @date_infos[index] = Array.new
      end
      @table[index] += [hw]
      @date_infos[index] += [display_date_info(hw)]
      count += 1
      if count == 3
        index += 1
        count = 0
      end
    end
  end

  def create
    groupCheck = Group.find_by_name_and_year_and_term_and_section(params[:group][:name],params[:group][:year],params[:group][:term],params[:group][:section])
    if groupCheck == nil
      @new = Group.create(name: params[:group][:name].upcase, year: params[:group][:year], term: params[:group][:term], section: params[:group][:section], public: params[:group][:public])
      @new.save!
      GroupUser.create(user_id: current_user.id, group_id: @new.id, membership: "admin")
      redirect_to homework_url
    else
      @groupName = params[:group][:name]
    end
  end

end
