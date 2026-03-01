# typed: strict
# frozen_string_literal: true

class ServicesController < ApplicationController
  include ActiveStorage::SetCurrent
  include PaginationParams
  include CollectionPaginator

  ActionController::Parameters.action_on_unpermitted_parameters = false

  def index
    # authorize services

    result = paginate_collection(
      Service.includes(:photos_blobs),
      order_by: :price,
      search_column: :title,
      search_value: search_value_param,
      page: page_param,
      per_page: per_page_param
    )

    render_success(
      message: "Servicios con foto principal del usuario actual cargados exitosamente",
      data: {
        services: ServiceBlueprint.render_as_hash(result[:records], view: :with_main_photo),
        pagination: result[:pagination]
      }
    )
  end

  def show
    # authorize services
    service = Service.find(params[:id])

    render_success(
      message: "Servicio con todas las fotos cargado exitosamente",
      data: ServiceBlueprint.render_as_hash(service, view: :detailed)
    )
  end

  def create
    service = current_user.company.services.new(service_params)
    # authorize services

    if service.save
      service.photos.attach(photos_array_to_hash)

      render_success(
        message: "Servicio creado exitosamente",
        code: :created,
        data: ServiceBlueprint.render_as_hash(service, view: :detailed)
      )
    else
      render_error(
        message: "Error al crear el servicio",
        code: :unprocessable_entity,
        details: service.errors.full_messages
      )
    end
  end

  def mine
    return render_error(message: "El usuario no tiene empresa asociada", code: :unprocessable_entity) unless current_user.company

    result = paginate_collection(
      current_user.company.services,
      order_by: :price,
      search_column: :title,
      search_value: search_value_param,
      page: page_param,
      per_page: per_page_param
    )

    render_success(
      message: "Servicios con foto principal del usuario actual cargados exitosamente",
      data: {
        services: ServiceBlueprint.render_as_hash(result[:records], view: :with_main_photo),
        pagination: result[:pagination]
      }
    )
  end

  def basic_mine
    return render_error(message: "El usuario no tiene empresa asociada", code: :unprocessable_entity) unless current_user.company

    services = current_user.company.services

    render_success(
      message: "Servicios básicos del usuario actual cargados exitosamente",
      data: ServiceBlueprint.render_as_hash(services, view: :default)
    )
  end

  def appointment_slots
    service = Service.find(params[:id])

    slots = AppointmentSlot
      .joins(:appointment_slot_services)
      .where(appointment_slot_services: { service_id: service.id })
      .where(state: :active)
      .where('appointment_slots.starting > ?', Time.zone.now)
      .order('appointment_slots.starting')

    data = slots.map do |slot|
      current_requests = Appointment
        .joins(:appointment_slot_service)
        .where(appointment_slot_services: { appointment_slot_id: slot.id })
        .where(state: :active)
        .count

      AppointmentSlotBlueprint.render_as_hash(slot, view: :default).merge(current_requests:)
    end

    render_success(
      message: "Turnos disponibles para el servicio cargados exitosamente",
      data:
    )
  end

  # rubocop: disable Metrics/AbcSize
  # def paginate_response
  #   @current_page = pagination_params[:page] || 1
  #   @per_page = pagination_params[:per_page] || 25
  #   search_field = params[:search_field]

  #   @services = Service.includes(:photos_blobs)
  #   @services = @services.where(title: search_field) if search_field.present?
  #   @services = @services.order(:price).page(@current_page).per(@per_page)

  #   @total_pages = @services.total_count
  #   @current_page = @total_pages if @current_page.to_i > @total_pages
  # end
  # rubocop: enable Metrics/AbcSize

  def photos_array_to_hash
    photos_params[:data].map.with_index do |image, idx|
      filename = "#{(Time.now.to_f * 1000).to_i}#{idx}"
      filename += '-main' if idx.zero?

      { data: image, filename: }
    end
  end

  def service_params
    params.permit(:title, :description, :price, :service_type_id)
  end

  def photos_params
    params.permit(data: [])
  end
end
