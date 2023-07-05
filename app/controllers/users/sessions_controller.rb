# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Logged in succesfully' },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }
  end

  def respond_to_on_destroy
    if current_user
      render json: { status: 200, message: 'Logged out succesfully' }, status: :ok
    else
      render json: { status: 401, message: 'Could not find an active session' }, status: :unauthorized
    end
  end
end
