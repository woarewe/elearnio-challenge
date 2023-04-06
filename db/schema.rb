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

ActiveRecord::Schema.define(version: 2023_04_06_200258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.uuid "public_id", default: -> { "gen_random_uuid()" }, null: false
    t.string "name", null: false
    t.bigint "author_id", null: false
    t.string "status", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_courses_on_author_id"
    t.index ["name"], name: "index_courses_on_name", unique: true
    t.index ["public_id"], name: "index_courses_on_public_id", unique: true
  end

  create_table "learning_material_assignments", force: :cascade do |t|
    t.bigint "talent_id", null: false
    t.string "learning_material_type", null: false
    t.bigint "learning_material_id", null: false
    t.string "status", null: false
    t.jsonb "info", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["talent_id", "learning_material_id", "learning_material_type"], name: "learning_material_assigments_uniq", unique: true
  end

  create_table "learning_path_slots", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "learning_path_id", null: false
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_learning_path_slots_on_course_id"
    t.index ["learning_path_id", "course_id"], name: "index_learning_path_slots_on_learning_path_id_and_course_id", unique: true
  end

  create_table "learning_paths", force: :cascade do |t|
    t.uuid "public_id", default: -> { "gen_random_uuid()" }, null: false
    t.string "name", null: false
    t.bigint "author_id", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_learning_paths_on_author_id"
    t.index ["name"], name: "index_learning_paths_on_name", unique: true
    t.index ["public_id"], name: "index_learning_paths_on_public_id", unique: true
  end

  create_table "talents", force: :cascade do |t|
    t.uuid "public_id", default: -> { "gen_random_uuid()" }, null: false
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_talents_on_email", unique: true
    t.index ["public_id"], name: "index_talents_on_public_id", unique: true
  end

  add_foreign_key "courses", "talents", column: "author_id"
  add_foreign_key "learning_material_assignments", "talents"
  add_foreign_key "learning_path_slots", "courses"
  add_foreign_key "learning_path_slots", "learning_paths"
  add_foreign_key "learning_paths", "talents", column: "author_id"
end
