# app/views/categories/index.json.jbuilder
json.services do
  json.array! @services do |service|
    json.id service.id
    json.title service.title
    json.description service.description
    json.price service.price
    json.service_type_id service.service_type_id
    json.user_id service.user_id
    json.url service.main_photo.url
  end
end

json.pagination do
  json.current_page @current_page
  json.total @total
  json.per_page @per_page
end
