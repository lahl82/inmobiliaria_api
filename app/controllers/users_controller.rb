# typed: strict
# frozen_string_literal: true

class UsersController < ApplicationController
  def services
    result = paginate_collection(Service.where(user_id: params[:id]), order_by: :price)

    render_success(
      message: "Servicios del usuario cargados exitosamente",
      data: {
        services: ServiceBlueprint.render_as_hash(result[:records]),
        pagination: result[:pagination]
      }
    )
  end
end
