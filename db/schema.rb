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

ActiveRecord::Schema.define(version: 2018_11_24_115821) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.bigint "mission_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mission_id"], name: "index_applications_on_mission_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "missions", force: :cascade do |t|
    t.string "title"
    t.string "category"
    t.string "address"
    t.integer "volunteers_needed"
    t.text "description"
    t.text "skills_needed"
    t.datetime "starting_at"
    t.integer "duration_in_hours"
    t.boolean "recurrent"
    t.integer "recurrency_in_days"
    t.date "recurrency_ending_on"
    t.date "end_candidature_date"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["organization_id"], name: "index_missions_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "kind"
    t.integer "total_volunteers"
    t.integer "siren"
    t.string "category"
    t.string "website"
    t.string "facebook"
    t.string "linkedin"
    t.string "twitter"
    t.string "address"
    t.string "creation_year"
    t.bigint "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "phone_number"
    t.index ["manager_id"], name: "index_organizations_on_manager_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.text "description"
    t.text "skills"
    t.text "experiences"
    t.string "picture"
    t.boolean "manager"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "applications", "missions"
  add_foreign_key "applications", "users"
  add_foreign_key "organizations", "users", column: "manager_id"
end
