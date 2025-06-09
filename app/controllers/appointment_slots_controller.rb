# typed: strict
# frozen_string_literal: true

class AppointmentSlotsController < ApplicationController
    # before_action :authenticate_user!

    # Listar los turnos del usuario actual
    def index
        slots = current_user.appointment_slots.order(:starting)
        render_success(
            message: "Turnos del usuario actual cargados exitosamente",
            code: :ok,
            data: AppointmentSlotBlueprint.render_as_hash(slots, view: :default)
        )
    end

    # Actualizar los servicios permitidos en un slot (ya lo tienes)
    def update_services
        slot = current_user.appointment_slots.find(params[:id])
        slot.service_ids = params[:service_ids]

        render_success(
            message: "Los servicios permitidos para el turno se actualizaron exitosamente",
            code: :created,
            data: AppointmentSlotBlueprint.render_as_hash(slot, view: :default)
        )
    end
end
