class Admin::GroupsController < Admin::ApplicationController
  load_and_authorize_resource :class => 'Group'
  respond_to :html, except: [:available]
  respond_to :json, only:   [:available]

  add_breadcrumb I18n.t('admin.breadcrumbs.home'), :root_path
  add_breadcrumb I18n.t('admin.breadcrumbs.groups.index'), :admin_groups_path

  def index
    if can?(:manage, Citygate::User)
      @groups = Group.paginate(page: params[:page], per_page: 10)
    else
      @groups = Group.paginate(page: params[:page], per_page: 10).find_all_by_user_id current_user.id
    end
  end

  def show
    @group = Group.find(params[:id])

    add_breadcrumb I18n.t('admin.breadcrumbs.groups.show'), admin_group_path(@group)
  end

  def new
    @group = Group.new

    add_breadcrumb I18n.t('admin.breadcrumbs.groups.new'), new_admin_group_path
  end

  def create
    @group = Group.new(params[:group])
    @group.user = current_user

    if @group.save
      flash[:notice] = t('admin.flash.group_created', name: @group.name)
    else
      flash[:error] = @group.errors.full_messages.last
    end

    respond_with(@group, location: admin_groups_path)
  end

  def update
    @group = Group.find(params[:id])
    contact_ids = params[:contact_ids].split(",") + @group.contact_ids

    if @group.update_attributes(params[:group].merge contact_ids: contact_ids)
      flash[:notice] = t('admin.flash.group_edited', name: @group.name)
    else
      flash[:error] = @group.errors.full_messages.last
    end

    respond_with(@group, location: admin_group_path(@group))
  end

  def edit
    @group = Group.find(params[:id])

    add_breadcrumb I18n.t('admin.breadcrumbs.groups.edit'), edit_admin_group_path(@group)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to admin_groups_path
  end

  def available
    if can?(:manage, Citygate::User)
      @groups = Group.select([:id, :name]).all
    else
      @groups = Group.find_all_by_user_id(current_user.id, select: [:id, :name])
    end
    @existing_groups = []
    if params[:contact] != "null"
      @existing_groups = Group.select([:id, :name]).where("id in(?)", Contact.find(params[:contact]).group_ids)
    end

    respond_with({available_groups: @groups, existing_groups: @existing_groups}.to_json)
  end
end
