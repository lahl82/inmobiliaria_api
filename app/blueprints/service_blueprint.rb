# app/blueprints/service_blueprint.rb
class ServiceBlueprint < Blueprinter::Base
  identifier :id

  # Vista por defecto (básica, sin fotos)
  view :default do
    fields :title, :description, :price, :service_type_id, :user_id, :state

    field :service_type do |service, _opts|
      service.service_type.name
    end
  end

  # Vista con foto principal incluida
  view :with_main_photo do
    include_view :default

    field :url do |service, _opts|
      service.main_photo&.url
    end
  end

  # Vista extendida (para show)
  view :detailed do
    include_view :default

    field :url do |service, _opts|
      service.all_url_photos
    end
  end
end
