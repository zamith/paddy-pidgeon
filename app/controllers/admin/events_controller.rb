class Admin::EventsController < Admin::ApplicationController
  load_and_authorize_resource :class => 'Event'
  respond_to :html

  add_breadcrumb I18n.t('admin.breadcrumbs.home'), :root_path
  add_breadcrumb I18n.t('admin.breadcrumbs.events.index'), :admin_events_path

  def index
    if can?(:manage, Citygate::User)
      @events = Event.order("start_date DESC, end_date ASC").paginate(page: params[:page], per_page: 10)
    else
      @events = Event.order("start_date DESC, end_date ASC").paginate(page: params[:page], per_page: 10).find_all_by_user_id current_user.id
    end
  end

  def show
    @event = Event.find(params[:id])

    add_breadcrumb I18n.t('admin.breadcrumbs.events.show'), admin_event_path(@event)
  end

  def new
    @event = Event.new

    add_breadcrumb I18n.t('admin.breadcrumbs.events.new'), new_admin_event_path
  end

  def create
    @event = Event.new(params[:event])
    @event.user = current_user

    if @event.save
      flash[:notice] = t('admin.flash.event_created', name: @event.name)
    else
      flash[:error] = @event.errors.full_messages.last
    end

    respond_with(@event, location: admin_events_path)
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      flash[:notice] = t('admin.flash.event_edited', name: @event.name)
    else
      flash[:error] = @event.errors.full_messages.last
    end

    respond_with(@event, location: admin_event_path(@event))
  end

  def edit
    @event = Event.find(params[:id])

    add_breadcrumb I18n.t('admin.breadcrumbs.events.edit'), edit_admin_event_path(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to admin_events_path
  end
end