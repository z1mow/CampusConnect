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

ActiveRecord::Schema[7.2].define(version: 2024_12_01_090000) do
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
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_name_index"
  end

  create_table "users_partition_0", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_0_name_idx"
  end

  create_table "users_partition_1", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_1_name_idx"
  end

  create_table "users_partition_10", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_10_name_idx"
  end

  create_table "users_partition_11", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_11_name_idx"
  end

  create_table "users_partition_12", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_12_name_idx"
  end

  create_table "users_partition_13", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_13_name_idx"
  end

  create_table "users_partition_14", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_14_name_idx"
  end

  create_table "users_partition_15", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_15_name_idx"
  end

  create_table "users_partition_2", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_2_name_idx"
  end

  create_table "users_partition_3", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_3_name_idx"
  end

  create_table "users_partition_4", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_4_name_idx"
  end

  create_table "users_partition_5", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_5_name_idx"
  end

  create_table "users_partition_6", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_6_name_idx"
  end

  create_table "users_partition_7", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_7_name_idx"
  end

  create_table "users_partition_8", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_8_name_idx"
  end

  create_table "users_partition_9", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "username"
    t.text "name", null: false
    t.text "email"
    t.text "password_digest"
    t.text "profile_picture"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "users_partition_9_name_idx"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "group_members", "community_groups"
  add_foreign_key "group_members", "users"
  add_foreign_key "group_members", "users_partition_0", column: "user_id", name: "group_members_user_id_fkey"
  add_foreign_key "group_members", "users_partition_1", column: "user_id", name: "group_members_user_id_fkey1"
  add_foreign_key "group_members", "users_partition_10", column: "user_id", name: "group_members_user_id_fkey10"
  add_foreign_key "group_members", "users_partition_11", column: "user_id", name: "group_members_user_id_fkey11"
  add_foreign_key "group_members", "users_partition_12", column: "user_id", name: "group_members_user_id_fkey12"
  add_foreign_key "group_members", "users_partition_13", column: "user_id", name: "group_members_user_id_fkey13"
  add_foreign_key "group_members", "users_partition_14", column: "user_id", name: "group_members_user_id_fkey14"
  add_foreign_key "group_members", "users_partition_15", column: "user_id", name: "group_members_user_id_fkey15"
  add_foreign_key "group_members", "users_partition_2", column: "user_id", name: "group_members_user_id_fkey2"
  add_foreign_key "group_members", "users_partition_3", column: "user_id", name: "group_members_user_id_fkey3"
  add_foreign_key "group_members", "users_partition_4", column: "user_id", name: "group_members_user_id_fkey4"
  add_foreign_key "group_members", "users_partition_5", column: "user_id", name: "group_members_user_id_fkey5"
  add_foreign_key "group_members", "users_partition_6", column: "user_id", name: "group_members_user_id_fkey6"
  add_foreign_key "group_members", "users_partition_7", column: "user_id", name: "group_members_user_id_fkey7"
  add_foreign_key "group_members", "users_partition_8", column: "user_id", name: "group_members_user_id_fkey8"
  add_foreign_key "group_members", "users_partition_9", column: "user_id", name: "group_members_user_id_fkey9"
end
