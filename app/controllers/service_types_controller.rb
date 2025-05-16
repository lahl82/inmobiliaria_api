class ServiceTypesController < ApplicationController
  def index
    # authorize services

    service_types = ServiceType.all
    render json: ServiceTypeBlueprint.render_as_hash(service_types, view: :default), status: :ok
  end
end
