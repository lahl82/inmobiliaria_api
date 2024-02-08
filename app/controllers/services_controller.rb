# typed: strict
# frozen_string_literal: true

class ServicesController < ApplicationController
  def index
    services = Service.all
    # authorize services
    render json: services
  end

  def show
    service = Service.find(params[:id])
    # authorize services
    render json: service
  end
end
