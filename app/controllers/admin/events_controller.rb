class Admin::EventsController < Admin::ApplicationController
  load_and_authorize_resource :class => "Event"
  respond_to :html

  def index
    @event = Event.all
  end

  def show
    @event = Event.find params[:id]
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new params[:event]
    @event.user = current_user

    flash[:notice] = t('flash.event_created', name: @event.name) if @event.save
    respond_with(:admin, @event)
  end

  def edit
    @event = Event.find params[:id]
  end
end