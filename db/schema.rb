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

ActiveRecord::Schema[8.0].define(version: 2025_05_02_085208) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "artist_exhibits", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "exhibit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id", "exhibit_id"], name: "index_artist_exhibits_on_artist_id_and_exhibit_id", unique: true
    t.index ["artist_id"], name: "index_artist_exhibits_on_artist_id"
    t.index ["exhibit_id"], name: "index_artist_exhibits_on_exhibit_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "biography"
    t.string "contact_email"
    t.string "contact_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exhibition_centers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "opening_hours"
    t.string "contact_email"
    t.string "contact_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exhibition_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exhibitions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "exhibition_center_id", null: false
    t.bigint "exhibition_type_id", null: false
    t.bigint "room_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibition_center_id"], name: "index_exhibitions_on_exhibition_center_id"
    t.index ["exhibition_type_id"], name: "index_exhibitions_on_exhibition_type_id"
    t.index ["room_id"], name: "index_exhibitions_on_room_id"
  end

  create_table "exhibits", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "width"
    t.float "height"
    t.float "depth"
    t.float "weight"
    t.bigint "exhibition_type_id", null: false
    t.bigint "room_id", null: false
    t.bigint "exhibition_id", null: false
    t.datetime "creation_date"
    t.string "material"
    t.boolean "copy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibition_id"], name: "index_exhibits_on_exhibition_id"
    t.index ["exhibition_type_id"], name: "index_exhibits_on_exhibition_type_id"
    t.index ["room_id"], name: "index_exhibits_on_room_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.datetime "purchase_date"
    t.datetime "purchase_time"
    t.string "customer_name"
    t.string "customer_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_purchases_on_ticket_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "exhibition_center_id", null: false
    t.string "name"
    t.float "width"
    t.float "height"
    t.float "depth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibition_center_id"], name: "index_rooms_on_exhibition_center_id"
  end

  create_table "ticket_types", force: :cascade do |t|
    t.string "type_name"
    t.string "description"
    t.float "discount"
    t.string "access_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "exhibition_id", null: false
    t.bigint "ticket_type_id", null: false
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibition_id"], name: "index_tickets_on_exhibition_id"
    t.index ["ticket_type_id"], name: "index_tickets_on_ticket_type_id"
  end

  add_foreign_key "artist_exhibits", "artists"
  add_foreign_key "artist_exhibits", "exhibits"
  add_foreign_key "exhibitions", "exhibition_centers"
  add_foreign_key "exhibitions", "exhibition_types"
  add_foreign_key "exhibitions", "rooms"
  add_foreign_key "exhibits", "exhibition_types"
  add_foreign_key "exhibits", "exhibitions"
  add_foreign_key "exhibits", "rooms"
  add_foreign_key "purchases", "tickets"
  add_foreign_key "rooms", "exhibition_centers"
  add_foreign_key "tickets", "exhibitions"
  add_foreign_key "tickets", "ticket_types"
end
