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

ActiveRecord::Schema.define(version: 2021_09_12_144524) do

  create_table "user_cards", id: { limit: 8 }, force: :cascade do |t|
    t.integer "user_id", limit: 8, null: false
    t.integer "card_id", limit: 8, null: false
    t.integer "exp", limit: 8, null: false
    t.time "created_at", null: false
    t.time "updated_at", null: false
  end

  create_table "user_crystals", id: { limit: 8 }, force: :cascade do |t|
    t.integer "user_id", limit: 8, null: false
    t.integer "free_count", limit: 8, null: false
    t.integer "paid_count", limit: 8, null: false
    t.time "created_at", null: false
    t.time "updated_at", null: false
  end

  create_table "user_items", id: { limit: 8 }, force: :cascade do |t|
    t.integer "user_id", limit: 8, null: false
    t.integer "item_category", limit: 8
    t.integer "count", limit: 8
    t.integer "item_id", limit: 8
    t.time "created_at", null: false
    t.time "updated_at", null: false
  end

  create_table "users", primary_key: "user_id", id: { limit: 8 }, force: :cascade do |t|
    t.string "session_token"
    t.string "device_id", null: false
    t.string "name", null: false
    t.time "created_at", null: false
    t.time "updated_at", null: false
    t.index ["device_id"], name: "index_users_on_device_id", unique: true, order: { device_id: :asc }
    t.index ["session_token"], name: "index_users_on_session_token", unique: true, order: { session_token: :asc }
  end

end
