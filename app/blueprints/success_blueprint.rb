# app/blueprints/success_blueprint.rb
class SuccessBlueprint < Blueprinter::Base
  fields :message, :code

  field :data, default: nil do |obj, _|
    obj[:data]
  end
end
