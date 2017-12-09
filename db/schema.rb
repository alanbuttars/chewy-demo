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

ActiveRecord::Schema.define(version: 1) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "colleges", force: :cascade do |t|
    t.string  "name",       null: false
    t.string  "alias"
    t.integer "enrollment", null: false
    t.string  "address",    null: false
    t.string  "city",       null: false
    t.string  "state",      null: false
    t.string  "zip",        null: false
    t.float   "latitude",   null: false
    t.float   "longitude",  null: false
    t.index ["alias"], name: "index_colleges_on_alias", using: :btree
    t.index ["latitude"], name: "index_colleges_on_latitude", using: :btree
    t.index ["longitude"], name: "index_colleges_on_longitude", using: :btree
    t.index ["name"], name: "index_colleges_on_name", using: :btree
  end

  create_table "colleges_labels", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "label_id",   null: false
    t.index ["college_id"], name: "index_colleges_labels_on_college_id", using: :btree
    t.index ["label_id"], name: "index_colleges_labels_on_label_id", using: :btree
  end

  create_table "employees", force: :cascade do |t|
    t.integer "college_id"
    t.string  "first_name", null: false
    t.string  "last_name",  null: false
    t.string  "email",      null: false
    t.index ["college_id"], name: "index_employees_on_college_id", using: :btree
    t.index ["email"], name: "index_employees_on_email", using: :btree
    t.index ["first_name"], name: "index_employees_on_first_name", using: :btree
    t.index ["last_name"], name: "index_employees_on_last_name", using: :btree
  end

  create_table "labels", force: :cascade do |t|
    t.string "code", null: false
    t.string "text", null: false
    t.index ["code"], name: "index_labels_on_code", using: :btree
  end

end
