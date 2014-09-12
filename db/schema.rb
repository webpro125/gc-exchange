# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140912135507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "address1",      limit: 128, null: false
    t.string   "address2",      limit: 128
    t.string   "city",          limit: 64,  null: false
    t.string   "state",         limit: 2,   null: false
    t.string   "zipcode",       limit: 5,   null: false
    t.float    "latitude",                  null: false
    t.float    "longitude",                 null: false
    t.integer  "consultant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["consultant_id"], name: "index_addresses_on_consultant_id", unique: true, using: :btree

  create_table "clearance_levels", force: true do |t|
    t.string   "code",       limit: 10, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consultant_skills", force: true do |t|
    t.integer  "consultant_id", null: false
    t.integer  "skill_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consultant_skills", ["consultant_id"], name: "index_consultant_skills_on_consultant_id", using: :btree
  add_index "consultant_skills", ["skill_id"], name: "index_consultant_skills_on_skill_id", using: :btree

  create_table "consultants", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
  end

  add_index "consultants", ["confirmation_token"], name: "index_consultants_on_confirmation_token", unique: true, using: :btree
  add_index "consultants", ["email"], name: "index_consultants_on_email", unique: true, using: :btree
  add_index "consultants", ["reset_password_token"], name: "index_consultants_on_reset_password_token", unique: true, using: :btree

  create_table "customer_names", force: true do |t|
    t.string "code", limit: 32, null: false
  end

  add_index "customer_names", ["code"], name: "index_customer_names_on_code", unique: true, using: :btree

  create_table "disciplines", force: true do |t|
    t.string "code", limit: 32
  end

  add_index "disciplines", ["code"], name: "index_disciplines_on_code", unique: true, using: :btree

  create_table "militaries", force: true do |t|
    t.integer  "rank_id"
    t.integer  "clearance_level_id"
    t.integer  "consultant_id",             null: false
    t.date     "investigation_date"
    t.date     "clearance_expiration_date"
    t.date     "service_start_date"
    t.date     "service_end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "militaries", ["clearance_level_id"], name: "index_militaries_on_clearance_level_id", using: :btree
  add_index "militaries", ["consultant_id"], name: "index_militaries_on_consultant_id", using: :btree
  add_index "militaries", ["rank_id"], name: "index_militaries_on_rank_id", using: :btree

  create_table "phone_types", force: true do |t|
    t.string "code", limit: 32, null: false
  end

  add_index "phone_types", ["code"], name: "index_phone_types_on_code", unique: true, using: :btree

  create_table "phones", force: true do |t|
    t.integer  "phoneable_id"
    t.string   "phoneable_type"
    t.integer  "phone_type_id",             null: false
    t.string   "number",         limit: 32, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phones", ["phone_type_id"], name: "index_phones_on_phone_type_id", using: :btree
  add_index "phones", ["phoneable_id", "phoneable_type"], name: "index_phones_on_phoneable_id_and_phoneable_type", using: :btree

  create_table "positions", force: true do |t|
    t.string "code", limit: 32, null: false
  end

  add_index "positions", ["code"], name: "index_positions_on_code", unique: true, using: :btree

  create_table "project_histories", force: true do |t|
    t.integer  "consultant_id",                null: false
    t.string   "client_company",   limit: 128
    t.string   "client_poc_name",  limit: 64
    t.string   "client_poc_email", limit: 128
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "position_id",                  null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_name_id"
  end

  add_index "project_histories", ["consultant_id"], name: "index_project_histories_on_consultant_id", using: :btree
  add_index "project_histories", ["customer_name_id"], name: "index_project_histories_on_customer_name_id", using: :btree
  add_index "project_histories", ["position_id"], name: "index_project_histories_on_position_id", using: :btree

  create_table "project_history_disciplines", force: true do |t|
    t.integer  "discipline_id",      null: false
    t.integer  "project_history_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_history_disciplines", ["discipline_id"], name: "index_project_history_disciplines_on_discipline_id", using: :btree
  add_index "project_history_disciplines", ["project_history_id"], name: "index_project_history_disciplines_on_project_history_id", using: :btree

  create_table "ranks", force: true do |t|
    t.string   "code",       limit: 10, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string   "code",       limit: 32, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["code"], name: "index_skills_on_code", unique: true, using: :btree

end
