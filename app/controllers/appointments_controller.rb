# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    appointments = current_user.appointments
                               .includes(appointment_slot_service: [:service, { appointment_slot: [] }])
                               .order(created_at: :desc)

    render_success(
      message: "Citas del usuario cargadas exitosamente",
      data: AppointmentBlueprint.render_as_hash(appointments, view: :default)
    )
  end

  def create
    slot_service = AppointmentSlotService.joins(:appointment_slot)
                                         .find_by(
                                           appointment_slot_id: params[:appointment_slot_id],
                                           service_id: params[:service_id]
                                         )

    unless slot_service
      return render_error(
        message: "Turno o servicio no encontrado",
        code: :not_found
      )
    end

    slot = slot_service.appointment_slot

    unless slot.active?
      return render_error(
        message: "El turno no está disponible",
        code: :unprocessable_entity
      )
    end

    unless slot.starting > Time.zone.now
      return render_error(
        message: "El turno ya pasó",
        code: :unprocessable_entity
      )
    end

    appointment = nil
    error_message = nil

    ActiveRecord::Base.transaction do
      slot.with_lock do
        already_booked = Appointment
          .joins(:appointment_slot_service)
          .where(appointment_slot_services: { appointment_slot_id: slot.id })
          .where(user_id: current_user.id)
          .where(state: :active)
          .exists?

        if already_booked
          error_message = "Ya tienes una cita activa en este turno"
          raise ActiveRecord::Rollback
        end

        current_requests = Appointment
          .joins(:appointment_slot_service)
          .where(appointment_slot_services: { appointment_slot_id: slot.id })
          .where(state: :active)
          .count

        if current_requests >= slot.max_requests
          error_message = "El turno ya no tiene cupo disponible"
          raise ActiveRecord::Rollback
        end

        appointment = Appointment.new(
          appointment_slot_service: slot_service,
          customer: current_user
        )
        appointment.save!
      end
    end

    if appointment&.persisted?
      render_success(
        message: "Cita reservada exitosamente",
        code: :created,
        data: AppointmentBlueprint.render_as_hash(appointment, view: :default)
      )
    else
      render_error(
        message: error_message || "Error al reservar la cita",
        code: :unprocessable_entity
      )
    end
  end

  def cancel
    appointment = current_user.appointments.find(params[:id])

    unless appointment.may_cancel_by_user?
      return render_error(
        message: "Esta cita no puede cancelarse",
        code: :unprocessable_entity
      )
    end

    if appointment.cancel_by_user!
      render_success(
        message: "Cita cancelada exitosamente",
        data: AppointmentBlueprint.render_as_hash(appointment, view: :default)
      )
    else
      render_error(
        message: "Error al cancelar la cita",
        code: :unprocessable_entity,
        details: appointment.errors.full_messages
      )
    end
  end
end
