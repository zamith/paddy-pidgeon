class ApplicationController < ActionController::Base
  protect_from_forgery

  helper Citygate::Engine.helpers

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to citygate_url, :alert => t('cancan.access_denied')
  end
end
