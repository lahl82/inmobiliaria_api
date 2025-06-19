# typed: strict
# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def create
    build_resource(user_params)

    assign_roles_and_company(resource)

    resource.save
    yield resource if block_given?
    respond_with(resource)
  end

  private
 
  def respond_with(current_user, _opts = {})
    if resource.persisted?
      render_success(
        message: "Usuario registrado exitosamente",
        data: {
          user: UserSessionBlueprint.render_as_hash(current_user, view: :default)
        },
        code: :created
      )
    else
      render_error(
        message: "No se pudo registrar el usuario",
        code: :unprocessable_entity,
        details: current_user.errors.full_messages
      )
    end

    # if resource.persisted?
    #   render json: {
    #     status: { success: true, message: "Usuario creado exitosamente" },
    #     data: current_user.as_json(only: [:id, :email, :name, :last_name])
    #   }, status: :created
    # else
    #   render json: {
    #     status: { success: false, message: current_user.errors.full_messages.to_sentence },
    #     errors: current_user.errors
    #   }, status: :unprocessable_entity
    # end
  end

  def assign_roles_and_company(user)
    wants_to_offer_services = ActiveModel::Type::Boolean.new.cast(raw_params[:wants_to_offer_services])
    business_name = raw_params[:business_name]

    if wants_to_offer_services
      company_name = business_name.presence || "#{user.name} #{user.last_name}"
      company = Company.new(name: company_name)

      if company.save
        user.company = company
        user.roles = [:admin]
      else
        user.errors.add(:company, company.errors.full_messages.join(', '))
      end
    else
      user.roles = [:customer]
    end
  end


  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :name, :last_name, :address, :phone, :document_type, :dni,
      :email, :password, :wants_to_offer_services, :business_name
    ])
  end

  def raw_params
    @raw_params ||= params.require(:user).permit(
      :name, :last_name, :address, :phone, :document_type, :dni,
      :email, :password, :wants_to_offer_services, :business_name
    )
  end

  def user_params
    raw_params.except(:wants_to_offer_services, :business_name)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
