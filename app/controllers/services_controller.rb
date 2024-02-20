# typed: strict
# frozen_string_literal: true

class ServicesController < ApplicationController
  ActionController::Parameters.action_on_unpermitted_parameters = false

  def index
    services = Service.all
    # authorize services
    render json: services
  end

  def show
    service = Service.find(params[:id])
    # authorize services
    render json: service
  end

  def create
    service = Service.new(service_params)
    # authorize services

    if service.save
      service.photos.attach(photos_array_to_hash)
      render json: service, status: :ok
    else
      render json: { error: 'Error creating Service' }, status: :not_found
    end
  end

  def photos_array_to_hash
    photos_params[:data].map { |image| { data: image } }
  end

  def service_params
    params.permit(:title, :description, :price, :service_type_id, :user_id)
  end

  def photos_params
    params.permit(data: [])
  end
end
