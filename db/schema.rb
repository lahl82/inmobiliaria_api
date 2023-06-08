# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_08_204319) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.string "name", null: false
    t.string "last_name", null: false
    t.string "phone", null: false
    t.text "address"
    t.string "agency", null: false
    t.string "avatar"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_agents_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "last_name", null: false
    t.text "address", null: false
    t.string "phone", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "images", null: false
    t.text "direction", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.float "area"
    t.integer "mode"
    t.integer "property_type", default: 0, null: false
    t.integer "state", default: 0
    t.integer "qty_bedroom"
    t.integer "qty_bathroom"
    t.integer "qty_floor"
    t.integer "qty_kitchen"
    t.integer "qty_parking"
    t.integer "qty_hall"
    t.boolean "is_private"
    t.boolean "office", default: false
    t.boolean "shop", default: false
    t.boolean "yard", default: false
    t.boolean "garden", default: false
    t.boolean "social", default: false
    t.bigint "agent_id", null: false
    t.bigint "residences_id"
    t.bigint "zones_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_properties_on_agent_id"
    t.index ["residences_id"], name: "index_properties_on_residences_id"
    t.index ["zones_id"], name: "index_properties_on_zones_id"
  end

  create_table "residences", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "zones_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["zones_id"], name: "index_residences_on_zones_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password", null: false
    t.integer "role", default: 2
    t.boolean "temporal_password", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visits", force: :cascade do |t|
    t.datetime "date", null: false
    t.bigint "property_id", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_visits_on_client_id"
    t.index ["property_id"], name: "index_visits_on_property_id"
  end

  create_table "zones", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "cities_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cities_id"], name: "index_zones_on_cities_id"
  end

  add_foreign_key "agents", "users"
  add_foreign_key "clients", "users"
  add_foreign_key "properties", "agents"
  add_foreign_key "residences", "zones", column: "zones_id"
  add_foreign_key "visits", "clients"
  add_foreign_key "visits", "properties"
  add_foreign_key "zones", "cities", column: "cities_id"
end
