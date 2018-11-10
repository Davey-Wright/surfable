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

  create_table "condition_conditions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "spot_session_id"
    t.index ["spot_session_id"], name: "index_condition_conditions_on_spot_session_id"
  end

  create_table "condition_swells", force: :cascade do |t|
    t.float "min_height"
    t.float "max_height"
    t.integer "min_period"
    t.string "direction", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "condition_id"
    t.index ["condition_id"], name: "index_condition_swells_on_condition_id"
  end

  create_table "condition_tides", force: :cascade do |t|
    t.float "position_low_high", default: [], array: true
    t.float "position_high_low", default: [], array: true
    t.string "size", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "condition_id"
    t.index ["condition_id"], name: "index_condition_tides_on_condition_id"
  end

  create_table "condition_winds", force: :cascade do |t|
    t.string "direction", default: [], array: true
    t.integer "speed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "condition_id"
    t.index ["condition_id"], name: "index_condition_winds_on_condition_id"
  end

  create_table "spot_sessions", force: :cascade do |t|
    t.string "name", null: false
    t.string "board_type", default: [], null: false, array: true
    t.bigint "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_spot_sessions_on_spot_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "name", null: false
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
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "condition_conditions", "spot_sessions"
end
