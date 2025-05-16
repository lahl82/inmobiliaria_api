class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name last_name phone role address avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name last_name phone role address avatar])
  end

  private

  def render_error(message:, code:, details: [])
    http_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[code] || code
    payload = { message:, code: http_code, details: }
    render json: ErrorBlueprint.render_as_hash(payload), status: http_code
  end

  def render_success(message:, code: :ok, data: nil)
    http_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[code] || code
    payload = { message:, code: http_code }
    payload[:data] = data if data.present?

    render json: SuccessBlueprint.render_as_hash(payload), status: http_code
  end

  def paginate_collection(scope, order_by: :created_at, search_column: nil, search_value: nil)
    current_page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 25).to_i

    if search_column.present? && search_value.present?
      scope = scope.where("#{search_column} ILIKE ?", "%#{search_value}%")
    end

    scope = scope.order(order_by).page(current_page).per(per_page)

    {
      records: scope,
      pagination: {
        current_page: scope.current_page,
        total_pages: scope.total_pages,
        per_page: scope.limit_value
      }
    }
  end
end
