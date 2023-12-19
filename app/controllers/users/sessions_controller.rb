# typed: strict
# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    render json:
            { status: { code: 200, message: 'Logged in successfully' },
              data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] } },
           status: :ok
  end

  def respond_to_on_destroy
    return unless request.headers['Authorization'].present?

    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last,
                             Rails.application.credentials.devise_jwt_secret_key!).first

    current_user = User.find(jwt_payload['sub'])

    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session"
      }, status: :unauthorized
    end
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
