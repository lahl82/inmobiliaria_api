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

    current_requests = Appointment
      .joins(:appointment_slot_service)
      .where(appointment_slot_services: { appointment_slot_id: slot.id })
      .where(state: :active)
      .count

    if current_requests >= slot.max_requests
      return render_error(
        message: "El turno ya no tiene cupo disponible",
        code: :unprocessable_entity
      )
    end

    appointment = Appointment.new(
      appointment_slot_service: slot_service,
      customer: current_user
    )

    if appointment.save
      render_success(
        message: "Cita reservada exitosamente",
        code: :created,
        data: AppointmentBlueprint.render_as_hash(appointment, view: :default)
      )
    else
      render_error(
        message: "Error al reservar la cita",
        code: :unprocessable_entity,
        details: appointment.errors.full_messages
      )
    end
  end
end
