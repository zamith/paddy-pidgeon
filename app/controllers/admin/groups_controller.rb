class Admin::GroupsController < Admin::ApplicationController
  load_and_authorize_resource :class => 'Group'
  respond_to :html, except: [:available]
  respond_to :json, only:   [:available]

  def index
    @group = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    @group.user = current_user

    flash[:notice] = t('flash.group_created', name: @group.name) if @group.save
    respond_with(:admin, @group)
  end

  def update
    @group = Group.find(params[:id])

    if @group.update_attributes(params[:group])
      flash[:notice] = t('flash.group_edited', name: @group.name)
    else
      # fail
    end

    redirect_to admin_group_path(@group)
  end

  def edit
    @group = Group.find(params[:id])
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to admin_groups_path
  end

  def available
    @groups = Group.find_all_by_user_id(current_user.id, select: [:id, :name])
    respond_with @groups
  end
end