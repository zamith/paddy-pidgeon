class Admin::EventsController < Admin::ApplicationController
  load_and_authorize_resource :class => "Event"
  respond_to :html



end