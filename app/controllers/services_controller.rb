# typed: strict
# frozen_string_literal: true

class ServicesController < ApplicationController
  include ActiveStorage::SetCurrent

  ActionController::Parameters.action_on_unpermitted_parameters = false

  def index
    @services = Service.includes(:photos_blobs).all
    # authorize services
    # render json: @services
  end

  def show
    @service = Service.find(params[:id])
    # authorize services
    # render json: { service:, url: service.photos.first.url }
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
    photos_params[:data].map.with_index do |image, idx|
      filename = "#{(Time.now.to_f * 1000).to_i}#{idx}"
      filename += '-main' if idx.zero?

      { data: image, filename: }
    end
  end

  def service_params
    params.permit(:title, :description, :price, :service_type_id, :user_id)
  end

  def photos_params
    params.permit(data: [])
  end
end
