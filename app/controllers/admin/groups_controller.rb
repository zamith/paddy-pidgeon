class Admin::GroupsController < Admin::ApplicationController
  load_and_authorize_resource :class => "Group"
  respond_to :html
end