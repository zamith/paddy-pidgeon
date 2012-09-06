class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to citygate_url, :alert => t('cancan.access_denied')
  end
end
