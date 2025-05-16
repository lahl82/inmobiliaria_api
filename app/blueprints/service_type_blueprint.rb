# app/blueprints/service_type_blueprint.rb
class ServiceTypeBlueprint < Blueprinter::Base
  identifier :id

  view :default do
    fields :name, :state
  end

  view :admin do
    include_view :default

    field :state_changed_at do |stype, _opts|
      stype.state_changed_at&.iso8601
    end
  end
end
