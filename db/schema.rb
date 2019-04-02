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

ActiveRecord::Schema.define(version: 2019_04_02_232520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.integer "day_of_week"
    t.time "start"
    t.time "end"
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

  create_table "non_user_tech_skills", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "non_tech_skill_id"
    t.index ["non_tech_skill_id"], name: "index_non_user_tech_skills_on_non_tech_skill_id"
    t.index ["user_id"], name: "index_non_user_tech_skills_on_user_id"
  end

  create_table "tech_skills", force: :cascade do |t|
    t.string "title"
  end

  create_table "user_identities", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "identity_id"
    t.index ["identity_id"], name: "index_user_identities_on_identity_id"
    t.index ["user_id"], name: "index_user_identities_on_user_id"
  end

  create_table "user_tech_skills", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tech_skill_id"
    t.index ["tech_skill_id"], name: "index_user_tech_skills_on_tech_skill_id"
    t.index ["user_id"], name: "index_user_tech_skills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "cohort"
    t.boolean "active"
    t.string "program"
    t.string "current_job"
    t.text "background"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "mentor"
  end

  add_foreign_key "availabilities", "users"
  add_foreign_key "contact_details", "users"
  add_foreign_key "non_user_tech_skills", "non_tech_skills"
  add_foreign_key "non_user_tech_skills", "users"
  add_foreign_key "user_identities", "identities"
  add_foreign_key "user_identities", "users"
  add_foreign_key "user_tech_skills", "tech_skills"
  add_foreign_key "user_tech_skills", "users"
end
