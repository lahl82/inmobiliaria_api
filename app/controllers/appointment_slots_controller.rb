# typed: strict
# frozen_string_literal: true

class AppointmentSlotsController < ApplicationController
    include ApiResponseHandler
    # before_action :authenticate_user!

    def index
        slots = current_user.appointment_slots.order(:starting)
        render_success(
            message: "Turnos del usuario actual cargados exitosamente",
            code: :ok,
            data: AppointmentSlotBlueprint.render_as_hash(slots, view: :default)
        )
    end

    def show
        slot = current_user.appointment_slots.find(params[:id])

        render_success(
            message: "Slot cargado exitosamente",
            data: AppointmentSlotBlueprint.render_as_hash(slot, view: :default),
            code: :ok
        )
    end

    def create
        slot = AppointmentSlot.new(appointment_slot_params)
        slot.user = current_user

        if slot.save
            render_success(
                message: "Slot creado exitosamente",
                data: AppointmentSlotBlueprint.render_as_hash(slot, view: :default),
                code: :created
            )
        else
            render_error(
                message: "Error al crear el slot",
                details: slot.errors.full_messages,
                code: :unprocessable_entity
            )
        end
    end

    def update
        slot = current_user.appointment_slots.find(params[:id])

        if slot.update(appointment_slot_params)
            render_success(
            message: "Slot actualizado exitosamente",
            data: AppointmentSlotBlueprint.render_as_hash(slot, view: :default),
            code: :ok
            )
        else
            render_error(
            message: "Error al actualizar el slot",
            code: :unprocessable_entity,
            details: slot.errors.full_messages
            )
        end
    end

    def suspend
        slot = current_user.appointment_slots.find(params[:id])
        if slot.may_suspend? && slot.suspend!
            render_success(
            message: "Slot suspendido exitosamente",
            code: :ok,
            data: AppointmentSlotBlueprint.render_as_hash(slot, view: :default)
            )
        else
            render_error(
            message: "Error al suspender el slot",
            code: :unprocessable_entity,
            details: slot.errors.full_messages
            )
        end
    end

    def resume
        slot = current_user.appointment_slots.find(params[:id])
        if slot.may_resume? && slot.resume!
            render_success(
            message: "Slot reanudado exitosamente",
            code: :ok,
            data: AppointmentSlotBlueprint.render_as_hash(slot, view: :default)
            )
        else
            render_error(
            message: "Error al reanudar el slot",
            code: :unprocessable_entity,
            details: slot.errors.full_messages
            )
        end
    end

    def destroy
        slot = current_user.appointment_slots.find(params[:id])
        if slot.destroy
            render_success(
            message: "Slot eliminado exitosamente",
            code: :ok,
            data: nil
            )
        else
            render_error(
            message: "Error al eliminar el slot",
            code: :unprocessable_entity,
            details: slot.errors.full_messages
            )
        end
    end

    def update_services
        slot = current_user.appointment_slots.find(params[:id])
        slot.service_ids = params[:service_ids]

        render_success(
            message: "Los servicios permitidos para el turno se actualizaron exitosamente",
            code: :created,
            data: AppointmentSlotBlueprint.render_as_hash(slot, view: :default)
        )
    end
   
    private

    # Permitir solo los parámetros permitidos
    def appointment_slot_params
        params.require(:appointment_slot).permit(:starting, :duration, :max_requests)
    end
end
