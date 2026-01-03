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

ActiveRecord::Schema[8.0].define(version: 2026_01_03_195643) do
  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.string "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "box_id"
    t.index ["box_id"], name: "index_actions_on_box_id"
  end

  create_table "box_files", force: :cascade do |t|
    t.integer "box_id", null: false
    t.string "filename"
    t.string "content_type"
    t.binary "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["box_id"], name: "index_box_files_on_box_id"
  end

  create_table "boxes", force: :cascade do |t|
    t.integer "number"
    t.string "room"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "packed_by"
  end

  add_foreign_key "actions", "boxes"
  add_foreign_key "box_files", "boxes"
end
