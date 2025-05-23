# typed: strict
# frozen_string_literal: true

class UsersController < ApplicationController
  include PaginationParams
  include CollectionPaginator

  def services
    result = paginate_collection(
      Service.where(user_id: params[:id]),
      order_by: :price,
      search_column: :title,
      search_value: search_value_param,
      page: page_param,
      per_page: per_page_param
    )

    render_success(
      message: "Servicios del usuario cargados exitosamente",
      data: {
        services: ServiceBlueprint.render_as_hash(result[:records]),
        pagination: result[:pagination]
      }
    )
  end
end
