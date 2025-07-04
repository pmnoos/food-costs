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

ActiveRecord::Schema[8.0].define(version: 2025_06_23_001345) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "menu_recipes", force: :cascade do |t|
    t.integer "menu_id", null: false
    t.integer "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id", "recipe_id"], name: "index_menu_recipes_on_menu_id_and_recipe_id", unique: true
    t.index ["menu_id"], name: "index_menu_recipes_on_menu_id"
    t.index ["recipe_id"], name: "index_menu_recipes_on_recipe_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name", null: false
    t.string "occasion", null: false
    t.date "date", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cuisine"
    t.integer "servings"
    t.text "description"
    t.index ["date"], name: "index_menus_on_date"
    t.index ["occasion"], name: "index_menus_on_occasion"
    t.index ["user_id"], name: "index_menus_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.decimal "unit_price"
    t.decimal "quantity"
    t.decimal "total_cost"
    t.integer "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "purchase_date"
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name", null: false
    t.string "cuisine", null: false
    t.string "difficulty", null: false
    t.integer "prep_time"
    t.integer "cook_time"
    t.integer "servings"
    t.text "instructions"
    t.text "ingredients"
    t.string "occasion"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine"], name: "index_recipes_on_cuisine"
    t.index ["difficulty"], name: "index_recipes_on_difficulty"
    t.index ["occasion"], name: "index_recipes_on_occasion"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "location"
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "menu_recipes", "menus"
  add_foreign_key "menu_recipes", "recipes"
  add_foreign_key "menus", "users"
  add_foreign_key "products", "stores"
  add_foreign_key "recipes", "users"
  add_foreign_key "stores", "users"
end
