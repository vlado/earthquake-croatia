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

ActiveRecord::Schema.define(version: 2021_01_03_235304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "ads", force: :cascade do |t|
    t.string "zip"
    t.string "phone"
    t.text "description"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "consent"
    t.string "address"
    t.integer "kind", default: 0, null: false
    t.integer "category", default: 0, null: false
    t.bigint "city_id", null: false
    t.index ["category"], name: "index_ads_on_category"
    t.index ["city_id"], name: "index_ads_on_city_id"
    t.index ["created_at"], name: "index_ads_on_created_at"
    t.index ["kind"], name: "index_ads_on_kind"
  end

  create_table "cities", force: :cascade do |t|
    t.string "area_name"
    t.bigint "county_id"
    t.string "name"
    t.integer "zip_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["county_id"], name: "index_cities_on_county_id"
  end

  create_table "counties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_counties_on_name"
  end

  add_foreign_key "ads", "cities"
  add_foreign_key "cities", "counties"
end
