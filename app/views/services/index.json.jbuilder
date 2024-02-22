# app/views/categories/index.json.jbuilder
json.array! @services do |service|
  json.id service.id
  json.title service.title
  json.description service.description
  json.price service.price
  json.service_type_id service.service_type_id
  json.user_id service.user_id
  json.url service.photos.first.url
end


# t.string "title", null: false
# t.text "description", null: false
# t.string "images"
# t.decimal "price", precision: 10, scale: 2, null: false
# t.string "aasm_state"
# t.bigint "service_type_id", null: false
# t.bigint "user_id", null: false
