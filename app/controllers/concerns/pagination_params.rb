module PaginationParams
  extend ActiveSupport::Concern

  included do
    # puedes añadir hooks si algún día lo necesitas
  end

  def page_param
    params[:page].to_i.positive? ? params[:page].to_i : 1
  end

  def per_page_param
    params[:per_page].to_i.positive? ? params[:per_page].to_i : 25
  end

  def search_value_param(key = :search_value)
    params[key].to_s.strip
  end
end
