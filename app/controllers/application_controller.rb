class ApplicationController < ActionController::API
  include ApiResponseHandler

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from StandardError, with: :handle_internal_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name last_name phone role address avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name last_name phone role address avatar])
  end

  private

  def handle_internal_error(exception)
    Rails.logger.error("[INTERNAL ERROR] #{exception.class}: #{exception.message}\n#{exception.backtrace&.take(10)&.join("\n")}")
    render_error(
      message: "Ha ocurrido un error inesperado.",
      code: :internal_server_error,
      details: [exception.message]
    )
  end

  def handle_not_found(exception)
    render_error(
      message: "Recurso no encontrado",
      code: :not_found,
      details: [exception.message]
    )
  end

  def handle_parameter_missing(exception)
    render_error(
      message: "Faltan parámetros requeridos",
      code: :unprocessable_entity,
      details: [exception.message]
    )
  end
end
