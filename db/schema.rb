# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_05_225605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "condition_swells", force: :cascade do |t|
    t.integer "rating", null: false
    t.float "min_height"
    t.float "max_height"
    t.integer "min_period"
    t.string "direction", default: [], array: true
    t.bigint "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_condition_swells_on_spot_id"
  end

  create_table "condition_tides", force: :cascade do |t|
    t.integer "rising", default: [], array: true
    t.integer "dropping", default: [], array: true
    t.integer "size", default: [], array: true
    t.bigint "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_condition_tides_on_spot_id"
  end

  create_table "condition_winds", force: :cascade do |t|
    t.integer "rating", null: false
    t.string "name", default: [], array: true
    t.string "direction", default: [], array: true
    t.integer "max_speed"
    t.bigint "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_condition_winds_on_spot_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "wave_break_type", default: [], array: true
    t.string "wave_shape", default: [], array: true
    t.string "wave_length", default: [], array: true
    t.string "wave_speed", default: [], array: true
    t.string "wave_direction", default: [], array: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_spots_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.boolean "demo", default: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
