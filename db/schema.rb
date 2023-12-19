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

ActiveRecord::Schema[7.1].define(version: 2023_12_05_149848) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "questions", force: :cascade do |t|
    t.text "description", null: false
    t.string "aasm_state"
    t.bigint "user_id", null: false
    t.bigint "service_id", null: false
    t.index ["service_id"], name: "index_questions_on_service_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.text "description", null: false
    t.string "aasm_state"
    t.bigint "user_id", null: false
    t.bigint "service_id", null: false
    t.index ["service_id"], name: "index_ratings_on_service_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.datetime "date", null: false
    t.string "aasm_state"
    t.bigint "service_id", null: false
    t.bigint "user_id", null: false
    t.index ["service_id"], name: "index_requests_on_service_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "images", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "aasm_state"
    t.bigint "service_type_id", null: false
    t.bigint "user_id", null: false
    t.index ["service_type_id"], name: "index_services_on_service_type_id"
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 2
    t.string "aasm_state"
    t.string "name", null: false
    t.string "last_name", null: false
    t.text "address", null: false
    t.string "phone", null: false
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "questions", "services"
  add_foreign_key "questions", "users"
  add_foreign_key "ratings", "services"
  add_foreign_key "ratings", "users"
  add_foreign_key "requests", "services"
  add_foreign_key "requests", "users"
  add_foreign_key "services", "service_types"
  add_foreign_key "services", "users"
end
