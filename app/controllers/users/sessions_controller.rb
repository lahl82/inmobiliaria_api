# typed: strict
# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  rescue_from JWT::ExpiredSignature, with: :expired_signature
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    @user_session = current_user
    # @token_session = request.env['warden-jwt_auth.token']
    # byebug
    # render json:
    #         { status: { code: 200, message: 'Logged in successfully' },
    #           data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] } },
    #        status: :ok
    
    # render json: UserSessionBlueprint.render_as_hash(@user_session, view: :login), status: :ok
    render_success(
      message: I18n.t('users.sessions.login_success'),
      data: {
        user: UserSessionBlueprint.render_as_hash(@user_session, view: :login)
      }
    )
  end

  def respond_to_on_destroy
    return if request.headers['Authorization'].blank?

    jwt_payload = JWT.decode(request.headers['Authorization'].split.last, Rails.application.credentials.devise_jwt_secret_key!).first

    current_user = User.find(jwt_payload['sub'])

    if current_user
      render_success(
        message: I18n.t('users.sessions.logout_success'),
        code: :ok,
      )
    else
      render_error(
        message: I18n.t('users.sessions.session_not_found'),
        code: :unauthorized
      )
    end
  end

  def expired_signature
    render_error(
      message: I18n.t('users.sessions.token_expired'),
      code: :unauthorized
    )
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  #   byebug
  #   @user = current_user
  #   render json: { user: @user,
  #                  token: @token }.to_json and return
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
