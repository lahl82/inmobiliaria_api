# app/blueprints/service_blueprint.rb
class ServiceBlueprint < Blueprinter::Base
  identifier :id

  # Vista por defecto (usada en index)
  view :default do
    fields :title, :description, :price, :service_type_id, :user_id

    field :url do |service, _opts|
      service.main_photo&.url
    end
  end

  # Vista extendida (para show)
  view :detailed do
    include_view :default

    field :service_type do |service, _opts|
      service.service_type.name
    end

    field :url do |service, _opts|
      service.all_url_photos
    end
  end
end
