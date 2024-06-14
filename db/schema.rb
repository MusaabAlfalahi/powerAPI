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

ActiveRecord::Schema[7.1].define(version: 2024_06_14_115649) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "power_banks", force: :cascade do |t|
    t.string "identifier"
    t.string "status"
    t.bigint "station_id"
    t.bigint "warehouse_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id"], name: "index_power_banks_on_station_id"
    t.index ["user_id"], name: "index_power_banks_on_user_id"
    t.index ["warehouse_id"], name: "index_power_banks_on_warehouse_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.bigint "location_id"
    t.bigint "warehouse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_stations_on_location_id"
    t.index ["warehouse_id"], name: "index_stations_on_warehouse_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.integer "isAdmin", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "power_banks", "stations"
  add_foreign_key "power_banks", "users"
  add_foreign_key "power_banks", "warehouses"
  add_foreign_key "stations", "locations"
  add_foreign_key "stations", "warehouses"
end
