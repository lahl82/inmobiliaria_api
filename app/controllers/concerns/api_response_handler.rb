module ApiResponseHandler
  extend ActiveSupport::Concern

  def render_error(message:, code:, details: [])
    http_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[code] || code
    payload = { message:, code: http_code, details: details }
    render json: ErrorBlueprint.render_as_hash(payload), status: http_code
  end

  def render_success(message:, code: :ok, data: nil)
    http_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[code] || code
    payload = { message:, code: http_code }
    payload[:data] = data if data.present?

    render json: SuccessBlueprint.render_as_hash(payload), status: http_code
  end
end
