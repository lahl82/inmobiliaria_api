# app/blueprints/service_type_blueprint.rb
class AppointmentSlotBlueprint < Blueprinter::Base
  identifier :id

  view :default do
    fields :starting, :duration, :max_requests, :state, :company_id
    field :service_ids do |slot|
      slot.service_ids
    end
  end

  view :admin do
    include_view :default
    field :state_changed_at do |stype, _opts|
      stype.state_changed_at&.iso8601
    end
  end
end
