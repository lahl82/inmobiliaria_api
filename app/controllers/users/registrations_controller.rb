# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    @user = User.new(user_params)
    
    if @user.save
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: UserSerializer.new(@user).serializable_hash[:data][:attributes]
      }
    else
      error_messages = resource.errors.messages.map { |field, messages| "#{field.capitalize} #{messages.join(', ')}" }
      render json: {
        status: { message: "User couldn't be created successfully. #{error_messages.join(' and ')}" }
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end