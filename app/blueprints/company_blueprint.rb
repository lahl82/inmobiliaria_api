class CompanyBlueprint < Blueprinter::Base
  identifier :id

  view :minimal do
    fields :name
  end
end
