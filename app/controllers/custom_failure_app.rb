# typed: strict
# frozen_string_literal: true

class CustomFailureApp < Devise::FailureApp
  def respond
    render_json_api_error
  end

  private

  def render_json_api_error
    error_payload = {
      message: i18n_message,
      code: 401,
      details: []
    }

    json = ErrorBlueprint.render_as_hash(error_payload)

    self.status = 401
    self.content_type = 'application/json'
    self.response_body = json.to_json
  end
end
