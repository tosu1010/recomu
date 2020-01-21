class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?

  def configure_permitted_parameters
    devise_keys = [:nickname]
    devise_parameter_sanitizer.permit(:sign_up, keys: devise_keys)
  end

  private
  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.basic_auth[:user_name] && password == Rails.application.credentials.basic_auth[:password]
    end
  end
end
