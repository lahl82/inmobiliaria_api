# typed: strict
# frozen_string_literal: true

class UsersController < ApplicationController
  def services
    services = Service.where(user_id: params[:id])
    # authorize services
    render json: services
  end
end
