# typed: strict
# frozen_string_literal: true

class ServicesController < ApplicationController
  include ActiveStorage::SetCurrent

  ActionController::Parameters.action_on_unpermitted_parameters = false

  def index
    paginate_response
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

  # rubocop: disable Metrics/AbcSize
  def paginate_response
    @current_page = pagination_params[:page] || 1
    @per_page = pagination_params[:per_page] || 25
    search_field = params[:search_field]

    @services = Service.includes(:photos_blobs)

    if search_field.present?
      @services = @services.where(title: search_field)
    end

    @total = @services.page(@current_page).per(@per_page).total_pages

    @current_page = @total if @current_page.to_i > @total
    @services.order(:price).page(@current_page).per(@per_page)
  end
  # rubocop: enable Metrics/AbcSize

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

  def pagination_params
    params.permit(:page, :per_page)
  end
end
