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

ActiveRecord::Schema[7.2].define(version: 2024_12_29_102128) do
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

  create_table "community_groups", force: :cascade do |t|
    t.string "name"
    t.integer "creator_id"
    t.text "description"
    t.string "category"
    t.boolean "default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_members", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "community_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_group_id"], name: "index_group_members_on_community_group_id"
    t.index ["user_id"], name: "index_group_members_on_user_id"
  end

  create_table "messages", primary_key: ["id", "created_at"], force: :cascade do |t|
    t.bigserial "id", null: false
    t.text "body", null: false
    t.integer "user_id", null: false
    t.bigint "community_group_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "messages_apr_2025_to_may_2025", primary_key: ["id", "created_at"], force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('messages_id_seq'::regclass)" }, null: false
    t.text "body", null: false
    t.integer "user_id", null: false
    t.bigint "community_group_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "messages_dec_2024_to_jan_2025", primary_key: ["id", "created_at"], force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('messages_id_seq'::regclass)" }, null: false
    t.text "body", null: false
    t.integer "user_id", null: false
    t.bigint "community_group_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "messages_default", primary_key: ["id", "created_at"], force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('messages_id_seq'::regclass)" }, null: false
    t.text "body", null: false
    t.integer "user_id", null: false
    t.bigint "community_group_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "messages_feb_2025_to_mar_2025", primary_key: ["id", "created_at"], force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('messages_id_seq'::regclass)" }, null: false
    t.text "body", null: false
    t.integer "user_id", null: false
    t.bigint "community_group_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "messages_jun_2025_to_jul_2025", primary_key: ["id", "created_at"], force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('messages_id_seq'::regclass)" }, null: false
    t.text "body", null: false
    t.integer "user_id", null: false
    t.bigint "community_group_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "profile_picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "group_members", "community_groups"
  add_foreign_key "group_members", "users"
end
