# typed: strict
# frozen_string_literal: true

class UsersController < ApplicationController
  include PaginationParams
  include CollectionPaginator

  def services
    result = paginate_collection(
      Service.where(user_id: params[:id]),
      order_by: :price,
      search_column: :title,
      search_value: search_value_param,
      page: page_param,
      per_page: per_page_param
    )

    render_success(
      message: "Servicios con foto principal del usuario cargados exitosamente",
      data: {
        services: ServiceBlueprint.render_as_hash(result[:records], view: :with_main_photo),
        pagination: result[:pagination]
      }
    )
  end

  def basic_services
    services = Service.where(user_id: params[:id]);

    render_success(
      message: "Servicios básicos del usuario cargados exitosamente",
      data: ServiceBlueprint.render_as_hash(services, view: :default)
    )
  end

  def appointment_slots
      slots = AppointmentSlot.where(user_id: params[:id]).order(:starting)
      render_success(
          message: "Turnos del usuario cargados exitosamente",
          code: :ok,
          data: AppointmentSlotBlueprint.render_as_hash(slots, view: :default)
      )
  end
end
