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

ActiveRecord::Schema.define(version: 2019_04_06_154752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.integer "day_of_week"
    t.boolean "morning"
    t.boolean "afternoon"
    t.boolean "evening"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_availabilities_on_user_id"
  end

  create_table "contact_details", force: :cascade do |t|
    t.string "email"
    t.string "slack"
    t.string "linkedin"
    t.string "phone"
    t.integer "preferred_method"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_contact_details_on_user_id"
  end

  create_table "identities", force: :cascade do |t|
    t.string "title"
  end

  create_table "non_tech_skills", force: :cascade do |t|
    t.string "title"
  end

  create_table "tech_skills", force: :cascade do |t|
    t.string "title"
  end

  create_table "user_identities", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "identities_id"
    t.index ["identities_id"], name: "index_user_identities_on_identities_id"
    t.index ["user_id"], name: "index_user_identities_on_user_id"
  end

  create_table "user_non_tech_skills", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "non_tech_skill_id"
    t.index ["non_tech_skill_id"], name: "index_user_non_tech_skills_on_non_tech_skill_id"
    t.index ["user_id"], name: "index_user_non_tech_skills_on_user_id"
  end

  create_table "user_tech_skills", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tech_skill_id"
    t.index ["tech_skill_id"], name: "index_user_tech_skills_on_tech_skill_id"
    t.index ["user_id"], name: "index_user_tech_skills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "cohort"
    t.boolean "active", default: true
    t.string "program"
    t.string "current_job", default: "student"
    t.text "background"
    t.string "location", default: "Denver, CO"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "mentor", default: false
  end

  add_foreign_key "availabilities", "users"
  add_foreign_key "contact_details", "users"
  add_foreign_key "user_identities", "identities", column: "identities_id"
  add_foreign_key "user_identities", "users"
  add_foreign_key "user_non_tech_skills", "non_tech_skills"
  add_foreign_key "user_non_tech_skills", "users"
  add_foreign_key "user_tech_skills", "tech_skills"
  add_foreign_key "user_tech_skills", "users"
end
