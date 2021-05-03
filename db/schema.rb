# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_01_091604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "searches", force: :cascade do |t|
    t.string "keyword", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["keyword"], name: "index_searches_on_keyword", unique: true
  end

  create_table "sounds", force: :cascade do |t|
    t.string "isrc", null: false
    t.string "thumbnail_url"
    t.string "title", null: false
    t.string "artist", null: false
    t.string "spotify_url"
    t.string "apple_music_url"
    t.string "kkbox_url"
    t.bigint "search_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_sounds_on_created_at"
    t.index ["search_id"], name: "index_sounds_on_search_id"
  end

  add_foreign_key "sounds", "searches"
end
