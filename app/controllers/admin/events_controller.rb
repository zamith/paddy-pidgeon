class Admin::EventsController < Admin::ApplicationController
  load_and_authorize_resource :class => 'Event'
  respond_to :html

  def index
    if can?(:manage, Citygate::User)
      @events = Event.paginate(page: params[:page], per_page: 10)
    else
      @events = Event.paginate(page: params[:page], per_page: 10).find_all_by_user_id current_user.id
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    @event.user = current_user

    if @event.save
      flash[:notice] = t('flash.event_created', name: @event.name)
    else
      flash[:error] = @event.errors.full_messages.last
    end

    respond_with(@event, location: admin_events_path)
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      flash[:notice] = t('flash.event_edited', name: @event.name)
    else
      flash[:error] = @event.errors.full_messages.last
    end

    respond_with(@event, location: admin_event_path(@event))
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to admin_events_path
  end
end