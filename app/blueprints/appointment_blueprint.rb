class AppointmentBlueprint < Blueprinter::Base
  identifier :id

  view :default do
    fields :state
    field :appointment_slot_service_id
    field :user_id
    field :starting do |apt|
      apt.appointment_slot_service.appointment_slot.starting.iso8601
    end
    field :service_id do |apt|
      apt.appointment_slot_service.service_id
    end
    field :service_name do |apt|
      apt.appointment_slot_service.service.title
    end
    field :duration do |apt|
      apt.appointment_slot_service.appointment_slot.duration
    end
  end
end
