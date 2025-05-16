# app/blueprints/error_blueprint.rb
class ErrorBlueprint < Blueprinter::Base
  field :message
  field :code
  field :details
end
