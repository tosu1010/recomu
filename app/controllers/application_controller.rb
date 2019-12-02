class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_keys = [:nickname]
    devise_parameter_sanitizer.permit(:sign_up, keys: devise_keys)
  end
end
