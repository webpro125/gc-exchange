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

ActiveRecord::Schema.define(version: 20160704133956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "account_managers", force: true do |t|
    t.string   "business_unit_name",  limit: 32, default: "", null: false
    t.string   "corporate_title",     limit: 32
    t.string   "phone",               limit: 32
    t.string   "avatar"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                          default: "", null: false
    t.string   "first_name",          limit: 24,              null: false
    t.string   "last_name",           limit: 24,              null: false
    t.string   "access_token"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "email_content",                  default: "", null: false
  end

  add_index "account_managers", ["company_id"], name: "index_account_managers_on_company_id", using: :btree
  add_index "account_managers", ["email"], name: "index_account_managers_on_email", unique: true, using: :btree
  add_index "account_managers", ["user_id"], name: "index_account_managers_on_user_id", using: :btree

  create_table "addresses", force: true do |t|
    t.float    "latitude",      null: false
    t.float    "longitude",     null: false
    t.integer  "consultant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "address",       null: false
  end

  add_index "addresses", ["consultant_id"], name: "index_addresses_on_consultant_id", unique: true, using: :btree

  create_table "admins", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 24,              null: false
    t.string   "last_name",              limit: 24,              null: false
    t.string   "phone",                             default: ""
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "approved_statuses", force: true do |t|
    t.string "code",  limit: 32
    t.string "label", limit: 256, null: false
  end

  add_index "approved_statuses", ["code"], name: "index_approved_statuses_on_code", unique: true, using: :btree

  create_table "article_attachments", force: true do |t|
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
  end

  add_index "article_attachments", ["article_id"], name: "index_article_attachments_on_article_id", using: :btree

  create_table "articles", force: true do |t|
    t.string   "title",      limit: 128
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",                 default: 0
    t.integer  "admin_id"
    t.integer  "views",                  default: 0
    t.json     "attaches"
  end

  add_index "articles", ["admin_id"], name: "index_articles_on_admin_id", using: :btree

  create_table "backgrounds", force: true do |t|
    t.integer  "consultant_id"
    t.boolean  "citizen",              null: false
    t.boolean  "convicted",            null: false
    t.boolean  "parole",               null: false
    t.boolean  "illegal_drug_use",     null: false
    t.boolean  "illegal_purchase",     null: false
    t.boolean  "illegal_prescription", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "backgrounds", ["consultant_id"], name: "index_backgrounds_on_consultant_id", using: :btree

  create_table "branches", force: true do |t|
    t.string   "code",       limit: 10,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label",      limit: 256, null: false
  end

  add_index "branches", ["code"], name: "index_branches_on_code", unique: true, using: :btree

  create_table "business_unit_roles", force: true do |t|
    t.boolean  "selection_authority",              default: false
    t.boolean  "approval_authority",               default: false
    t.boolean  "requisition_authority",            default: false
    t.integer  "account_manager_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                            default: "",    null: false
    t.string   "first_name",            limit: 24,                 null: false
    t.string   "last_name",             limit: 24,                 null: false
    t.boolean  "ra_accept",                        default: false
    t.boolean  "sa_accept",                        default: false
    t.boolean  "aa_accept",                        default: false
    t.string   "phone",                 limit: 32
    t.string   "accept_token"
  end

  add_index "business_unit_roles", ["account_manager_id"], name: "index_business_unit_roles_on_account_manager_id", using: :btree
  add_index "business_unit_roles", ["email", "account_manager_id"], name: "index_business_unit_roles_on_email_and_account_manager_id", unique: true, using: :btree
  add_index "business_unit_roles", ["user_id"], name: "index_business_unit_roles_on_user_id", using: :btree

  create_table "certifications", force: true do |t|
    t.string "code",  limit: 32,  null: false
    t.string "label", limit: 256, null: false
  end

  add_index "certifications", ["code"], name: "index_certifications_on_code", unique: true, using: :btree

  create_table "clearance_levels", force: true do |t|
    t.string "code",  limit: 32,  null: false
    t.string "label", limit: 256, null: false
  end

  create_table "comment_attachments", force: true do |t|
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
  end

  add_index "comment_attachments", ["comment_id"], name: "index_comment_attachments_on_comment_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "article_id"
    t.integer  "commenter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_commenter_id"
  end

  add_index "comments", ["admin_commenter_id"], name: "index_comments_on_admin_commenter_id", using: :btree
  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree
  add_index "comments", ["commenter_id"], name: "index_comments_on_commenter_id", using: :btree

  create_table "companies", force: true do |t|
    t.string   "company_name",           limit: 512
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",                         default: "",    null: false
    t.string   "last_name",                          default: "",    null: false
    t.string   "phone",                  limit: 32,  default: "",    null: false
    t.date     "contract_start"
    t.date     "contract_end"
    t.boolean  "require_contract_rider",             default: false
    t.string   "contract_file_name"
    t.string   "contract_content_type"
    t.integer  "contract_file_size"
    t.datetime "contract_updated_at"
    t.string   "email",                              default: "",    null: false
    t.string   "gsc"
    t.string   "gsc_file_name"
    t.string   "gsc_content_type"
    t.integer  "gsc_file_size"
    t.datetime "gsc_updated_at"
  end

  add_index "companies", ["owner_id"], name: "index_companies_on_owner_id", using: :btree

  create_table "consultant_certifications", force: true do |t|
    t.integer "consultant_id",    null: false
    t.integer "certification_id", null: false
  end

  add_index "consultant_certifications", ["certification_id"], name: "index_consultant_certifications_on_certification_id", using: :btree
  add_index "consultant_certifications", ["consultant_id", "certification_id"], name: "consultant_certifications_uniqueness", unique: true, using: :btree
  add_index "consultant_certifications", ["consultant_id"], name: "index_consultant_certifications_on_consultant_id", using: :btree

  create_table "consultant_skills", force: true do |t|
    t.integer  "consultant_id", null: false
    t.integer  "skill_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consultant_skills", ["consultant_id", "skill_id"], name: "index_consultant_skills_on_consultant_id_and_skill_id", unique: true, using: :btree
  add_index "consultant_skills", ["consultant_id"], name: "index_consultant_skills_on_consultant_id", using: :btree
  add_index "consultant_skills", ["skill_id"], name: "index_consultant_skills_on_skill_id", using: :btree

  create_table "consultants", force: true do |t|
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
    t.integer  "approved_status_id",                                 default: 1,    null: false
    t.decimal  "rate",                       precision: 8, scale: 2
    t.text     "abstract"
    t.string   "wizard_step"
    t.boolean  "willing_to_travel",                                  default: true
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
    t.datetime "contract_effective_date"
    t.datetime "date_on_hold"
    t.datetime "date_pending_approval"
    t.datetime "date_approved"
    t.datetime "date_rejected"
    t.string   "contract_version"
    t.integer  "approval_number"
    t.boolean  "sms_notification",                                   default: true
    t.integer  "user_id"
  end

  add_index "consultants", ["approved_status_id"], name: "index_consultants_on_approved_status_id", using: :btree
  add_index "consultants", ["user_id"], name: "index_consultants_on_user_id", using: :btree

  create_table "customer_names", force: true do |t|
    t.string "code",  limit: 32,  null: false
    t.string "label", limit: 256, null: false
  end

  add_index "customer_names", ["code"], name: "index_customer_names_on_code", unique: true, using: :btree

  create_table "degrees", force: true do |t|
    t.string "code",  limit: 32,  null: false
    t.string "label", limit: 256, null: false
  end

  add_index "degrees", ["code"], name: "index_degrees_on_code", unique: true, using: :btree
  add_index "degrees", ["label"], name: "index_degrees_on_label", unique: true, using: :btree

  create_table "educations", force: true do |t|
    t.integer  "consultant_id",              null: false
    t.integer  "degree_id",                  null: false
    t.string   "school",         limit: 256
    t.string   "field_of_study", limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "educations", ["consultant_id"], name: "index_educations_on_consultant_id", using: :btree
  add_index "educations", ["degree_id"], name: "index_educations_on_degree_id", using: :btree

  create_table "entities", force: true do |t|
    t.integer  "entity_type"
    t.string   "title"
    t.string   "name"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "consultant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailboxer_conversation_opt_outs", force: true do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "markets", force: true do |t|
    t.string  "code"
    t.string  "label"
    t.integer "market_id"
  end

  create_table "metrics", force: true do |t|
    t.string   "loggable_type"
    t.integer  "loggable_id"
    t.string   "metric_type",   null: false
    t.hstore   "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "militaries", force: true do |t|
    t.integer  "rank_id"
    t.integer  "clearance_level_id"
    t.integer  "consultant_id",                             null: false
    t.date     "investigation_date"
    t.date     "clearance_expiration_date"
    t.date     "service_start_date"
    t.date     "service_end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "clearance_active",          default: false, null: false
    t.integer  "branch_id"
    t.boolean  "military",                  default: false
  end

  add_index "militaries", ["branch_id"], name: "index_militaries_on_branch_id", using: :btree
  add_index "militaries", ["clearance_level_id"], name: "index_militaries_on_clearance_level_id", using: :btree
  add_index "militaries", ["consultant_id"], name: "index_militaries_on_consultant_id", using: :btree
  add_index "militaries", ["rank_id"], name: "index_militaries_on_rank_id", using: :btree

  create_table "phone_types", force: true do |t|
    t.string "code",  limit: 32,  null: false
    t.string "label", limit: 256, null: false
  end

  add_index "phone_types", ["code"], name: "index_phone_types_on_code", unique: true, using: :btree

  create_table "phones", force: true do |t|
    t.integer  "phoneable_id"
    t.string   "phoneable_type"
    t.integer  "phone_type_id"
    t.string   "number",         limit: 32
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "primary",                   default: false
    t.string   "ext"
  end

  add_index "phones", ["phone_type_id"], name: "index_phones_on_phone_type_id", using: :btree
  add_index "phones", ["phoneable_id", "phoneable_type"], name: "index_phones_on_phoneable_id_and_phoneable_type", using: :btree

  create_table "positions", force: true do |t|
    t.string  "code",      limit: 32,              null: false
    t.string  "label",     limit: 256,             null: false
    t.integer "market_id",             default: 1
  end

  add_index "positions", ["code"], name: "index_positions_on_code", unique: true, using: :btree

  create_table "project_agreements", force: true do |t|
    t.boolean  "project_name_agreement",         default: true
    t.text     "project_name_reason"
    t.boolean  "project_period_agreement",       default: true
    t.text     "project_period_reason"
    t.boolean  "consultant_location_agreement",  default: true
    t.text     "consultant_location_reason"
    t.boolean  "travel_authorization_agreement", default: true
    t.text     "travel_authorization_reason"
    t.boolean  "consultant_rate_agreement",      default: true
    t.text     "consultant_rate_reason"
    t.boolean  "sow_agreement",                  default: true
    t.text     "sow_reason"
    t.integer  "status",                         default: 0
    t.integer  "consultant_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_agreements", ["consultant_id"], name: "index_project_agreements_on_consultant_id", using: :btree
  add_index "project_agreements", ["project_id"], name: "index_project_agreements_on_project_id", using: :btree

  create_table "project_files", force: true do |t|
    t.string   "sow"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sow_file_name"
    t.string   "sow_content_type"
    t.integer  "sow_file_size"
    t.datetime "sow_updated_at"
  end

  add_index "project_files", ["project_id"], name: "index_project_files_on_project_id", using: :btree

  create_table "project_histories", force: true do |t|
    t.integer  "consultant_id",                null: false
    t.string   "client_company",   limit: 512
    t.string   "client_poc_name",  limit: 256
    t.string   "client_poc_email", limit: 128
    t.date     "start_date"
    t.date     "end_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_name_id"
    t.integer  "project_type_id"
  end

  add_index "project_histories", ["consultant_id"], name: "index_project_histories_on_consultant_id", using: :btree
  add_index "project_histories", ["customer_name_id"], name: "index_project_histories_on_customer_name_id", using: :btree
  add_index "project_histories", ["project_type_id"], name: "index_project_histories_on_project_type_id", using: :btree

  create_table "project_history_positions", force: true do |t|
    t.integer "project_history_id"
    t.integer "position_id"
    t.integer "percentage"
  end

  add_index "project_history_positions", ["position_id"], name: "index_project_history_positions_on_position_id", using: :btree
  add_index "project_history_positions", ["project_history_id"], name: "index_project_history_positions_on_project_history_id", using: :btree

  create_table "project_types", force: true do |t|
    t.string "code",  limit: 32,  null: false
    t.string "label", limit: 256, null: false
  end

  add_index "project_types", ["code"], name: "index_project_types_on_code", unique: true, using: :btree

  create_table "projects", force: true do |t|
    t.integer  "consultant_id",                                                         null: false
    t.integer  "user_id",                                                               null: false
    t.date     "proposed_start"
    t.date     "proposed_end"
    t.decimal  "proposed_rate",                     precision: 8, scale: 2
    t.integer  "contact_status",                                            default: 0
    t.string   "project_name",          limit: 128
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "travel_authorization"
    t.integer  "consultant_location"
    t.text     "summarize_statement"
    t.boolean  "rate_approve"
    t.string   "sow"
    t.string   "sow_file_name"
    t.string   "sow_content_type"
    t.integer  "sow_file_size"
    t.datetime "sow_updated_at"
    t.integer  "business_unit_role_id"
  end

  add_index "projects", ["business_unit_role_id"], name: "index_projects_on_business_unit_role_id", using: :btree
  add_index "projects", ["consultant_id"], name: "index_projects_on_consultant_id", using: :btree
  add_index "projects", ["project_name"], name: "index_projects_on_project_name", unique: true, using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "ra_project_agreements", force: true do |t|
    t.boolean  "project_name_agreement",         default: true
    t.text     "project_name_reason"
    t.boolean  "project_period_agreement",       default: true
    t.text     "project_period_reason"
    t.boolean  "consultant_location_agreement",  default: true
    t.text     "consultant_location_reason"
    t.boolean  "travel_authorization_agreement", default: true
    t.text     "travel_authorization_reason"
    t.boolean  "consultant_rate_agreement",      default: true
    t.text     "consultant_rate_reason"
    t.boolean  "sow_agreement",                  default: true
    t.text     "sow_reason"
    t.integer  "status",                         default: 0
    t.integer  "project_agreement_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ra_project_agreements", ["project_agreement_id"], name: "index_ra_project_agreements_on_project_agreement_id", using: :btree
  add_index "ra_project_agreements", ["user_id"], name: "index_ra_project_agreements_on_business_unit_role_id", using: :btree

  create_table "ranks", force: true do |t|
    t.string "code",  limit: 32,  null: false
    t.string "label", limit: 256, null: false
  end

  create_table "requested_companies", force: true do |t|
    t.string   "company_name",   limit: 128,                 null: false
    t.string   "work_phone",     limit: 32,                  null: false
    t.string   "cell_phone",     limit: 32,                  null: false
    t.string   "work_phone_ext"
    t.text     "help_content"
    t.boolean  "is_read",                    default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requested_companies", ["user_id"], name: "index_requested_companies_on_user_id", using: :btree

  create_table "sales_leads", force: true do |t|
    t.string   "first_name",   limit: 24,  null: false
    t.string   "last_name",    limit: 24,  null: false
    t.string   "company_name", limit: 128, null: false
    t.string   "phone_number",             null: false
    t.string   "email",        limit: 128, null: false
    t.text     "message",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sales_leads", ["email"], name: "index_sales_leads_on_email", unique: true, using: :btree

  create_table "shared_contacts", force: true do |t|
    t.integer  "consultant_id",                 null: false
    t.integer  "user_id",                       null: false
    t.boolean  "allowed",       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shared_contacts", ["consultant_id"], name: "index_shared_contacts_on_consultant_id", using: :btree
  add_index "shared_contacts", ["user_id", "consultant_id"], name: "index_shared_contacts_on_user_id_and_consultant_id", unique: true, using: :btree
  add_index "shared_contacts", ["user_id"], name: "index_shared_contacts_on_user_id", using: :btree

  create_table "skills", force: true do |t|
    t.string "code", limit: 128, null: false
  end

  add_index "skills", ["code"], name: "index_skills_on_code", unique: true, using: :btree

  create_table "travel_authorizations", force: true do |t|
    t.string "code",  limit: 32,  null: false
    t.string "label", limit: 256, null: false
  end

  add_index "travel_authorizations", ["code"], name: "index_travel_authorizations_on_code", unique: true, using: :btree
  add_index "travel_authorizations", ["label"], name: "index_travel_authorizations_on_label", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                                 default: "", null: false
    t.string   "encrypted_password",                    default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                       default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name",                 limit: 24,              null: false
    t.string   "last_name",                  limit: 24,              null: false
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "work_location_addresses", force: true do |t|
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "st"
    t.string   "zip_code"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", name: "notifications_on_conversation_id", column: "conversation_id"

  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", name: "receipts_on_notification_id", column: "notification_id"

end
