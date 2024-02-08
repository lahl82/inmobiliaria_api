class ServiceTypesController < ApplicationController
  def index
    service_types = ServiceType.all
    # authorize services
    render json: service_types
  end
end
