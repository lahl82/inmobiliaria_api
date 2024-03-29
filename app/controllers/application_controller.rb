class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name last_name phone role address avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name last_name phone role address avatar])
  end
end
