# app/views/categories/show.json.jbuilder
json.id @service.id
json.title @service.title
json.description @service.description
json.price @service.price
json.service_type_id @service.service_type_id
json.user_id @service.user_id
json.url1 @service.photos.first.url
json.url2 rails_blob_path(@service.photos.first)
