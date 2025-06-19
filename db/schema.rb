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

ActiveRecord::Schema[7.1].define(version: 2023_12_09_191610) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "appointment_slot_services", force: :cascade do |t|
    t.string "state"
    t.datetime "state_changed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_id", null: false
    t.bigint "appointment_slot_id", null: false
    t.index ["appointment_slot_id", "service_id"], name: "idx_on_appointment_slot_id_service_id_6e2f9f26ca", unique: true
    t.index ["appointment_slot_id"], name: "index_appointment_slot_services_on_appointment_slot_id"
    t.index ["service_id"], name: "index_appointment_slot_services_on_service_id"
  end

  create_table "appointment_slots", force: :cascade do |t|
    t.datetime "starting", null: false
    t.integer "duration", null: false
    t.integer "max_requests", default: 1, null: false
    t.string "state", null: false
    t.datetime "state_changed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_appointment_slots_on_company_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.string "state"
    t.datetime "state_changed_at"
    t.bigint "appointment_slot_service_id", null: false
    t.bigint "user_id", null: false
    t.index ["appointment_slot_service_id"], name: "index_appointments_on_appointment_slot_service_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "state"
    t.datetime "state_changed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.text "description", null: false
    t.datetime "sent_at", null: false
    t.string "state", null: false
    t.datetime "state_changed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "appointment_id", null: false
    t.index ["appointment_id"], name: "index_notifications_on_appointment_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "description", null: false
    t.text "answer"
    t.string "state"
    t.datetime "state_changed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "service_id", null: false
    t.index ["service_id"], name: "index_questions_on_service_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.text "description", null: false
    t.integer "score", null: false
    t.string "state"
    t.datetime "state_changed_at"
    t.bigint "user_id", null: false
    t.bigint "appointment_id", null: false
    t.index ["appointment_id"], name: "index_ratings_on_appointment_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "state"
    t.datetime "state_changed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "state"
    t.datetime "state_changed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_type_id", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_services_on_company_id"
    t.index ["service_type_id"], name: "index_services_on_service_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role_mask", default: 0
    t.string "state"
    t.string "name", null: false
    t.string "last_name", null: false
    t.string "document_type", null: false
    t.string "dni", null: false
    t.text "address", null: false
    t.string "phone", null: false
    t.string "avatar"
    t.datetime "state_changed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.string "jti", null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["dni"], name: "index_users_on_dni", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointment_slot_services", "appointment_slots"
  add_foreign_key "appointment_slot_services", "services"
  add_foreign_key "appointment_slots", "companies"
  add_foreign_key "appointments", "appointment_slot_services"
  add_foreign_key "appointments", "users"
  add_foreign_key "notifications", "appointments"
  add_foreign_key "questions", "services"
  add_foreign_key "questions", "users"
  add_foreign_key "ratings", "appointments"
  add_foreign_key "ratings", "users"
  add_foreign_key "services", "companies"
  add_foreign_key "services", "service_types"
  add_foreign_key "users", "companies"
end
