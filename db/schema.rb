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

ActiveRecord::Schema.define(version: 20150813160117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "balances", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.decimal  "money",      default: 0.0
  end

  add_index "balances", ["user_id"], name: "index_balances_on_user_id", using: :btree

  create_table "bank_names", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billings", force: :cascade do |t|
    t.integer  "bank_name_id"
    t.integer  "string"
    t.string   "owner"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id",        null: false
    t.string   "account_number"
    t.string   "branch"
    t.string   "city"
  end

  add_index "billings", ["bank_name_id"], name: "index_billings_on_bank_name_id", using: :btree

  create_table "complaint_services", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "service_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "complaint_services", ["service_id"], name: "index_complaint_services_on_service_id", using: :btree

  create_table "confirmation_deposits", force: :cascade do |t|
    t.integer  "deposit_id"
    t.integer  "user_id"
    t.integer  "bank_name_id"
    t.datetime "date_transfer"
    t.string   "no_credit"
    t.string   "name_owner_credit"
    t.decimal  "money"
    t.string   "attach"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "confirmation_deposits", ["bank_name_id"], name: "index_confirmation_deposits_on_bank_name_id", using: :btree
  add_index "confirmation_deposits", ["deposit_id"], name: "index_confirmation_deposits_on_deposit_id", using: :btree
  add_index "confirmation_deposits", ["user_id"], name: "index_confirmation_deposits_on_user_id", using: :btree

  create_table "confirmation_request_products", force: :cascade do |t|
    t.integer  "request_product_id"
    t.integer  "quantity_available"
    t.integer  "status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "confirmation_request_products", ["request_product_id"], name: "index_confirmation_request_products_on_request_product_id", using: :btree

  create_table "confirmation_requests", force: :cascade do |t|
    t.integer  "request_id"
    t.decimal  "delivery_fee"
    t.integer  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "confirmation_requests", ["request_id"], name: "index_confirmation_requests_on_request_id", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.string   "token"
    t.decimal  "money"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "limit_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deposits", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "money"
    t.integer  "status",     default: 1
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "token"
    t.boolean  "trash",      default: false
  end

  add_index "deposits", ["user_id"], name: "index_deposits_on_user_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.text    "description"
    t.integer "user_id"
    t.integer "service_id"
  end

  add_index "feedbacks", ["service_id"], name: "index_feedbacks_on_service_id", using: :btree
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "follows", force: :cascade do |t|
    t.string   "follower_type"
    t.integer  "follower_id"
    t.string   "followable_type"
    t.integer  "followable_id"
    t.datetime "created_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "foto_product_services", force: :cascade do |t|
    t.integer  "product_service_id"
    t.string   "avatar"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "foto_product_services", ["product_service_id"], name: "index_foto_product_services_on_product_service_id", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer "friendable_id"
    t.integer "friend_id"
    t.integer "blocker_id"
    t.boolean "pending",       default: true
  end

  add_index "friendships", ["friendable_id", "friend_id"], name: "index_friendships_on_friendable_id_and_friend_id", unique: true, using: :btree

  create_table "likes", force: :cascade do |t|
    t.string   "liker_type"
    t.integer  "liker_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], name: "fk_likeables", using: :btree
  add_index "likes", ["liker_id", "liker_type"], name: "fk_likes", using: :btree

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
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

  create_table "mailboxer_receipts", force: :cascade do |t|
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

  create_table "mentions", force: :cascade do |t|
    t.string   "mentioner_type"
    t.integer  "mentioner_id"
    t.string   "mentionable_type"
    t.integer  "mentionable_id"
    t.datetime "created_at"
  end

  add_index "mentions", ["mentionable_id", "mentionable_type"], name: "fk_mentionables", using: :btree
  add_index "mentions", ["mentioner_id", "mentioner_type"], name: "fk_mentions", using: :btree

  create_table "order_coupons", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "coupon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_coupons", ["coupon_id"], name: "index_order_coupons_on_coupon_id", using: :btree
  add_index "order_coupons", ["user_id"], name: "index_order_coupons_on_user_id", using: :btree

  create_table "product_services", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "service_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "price",       default: 0
    t.boolean  "takeaway"
    t.boolean  "delivery"
  end

  add_index "product_services", ["service_id"], name: "index_product_services_on_service_id", using: :btree

  create_table "read_marks", force: :cascade do |t|
    t.integer  "readable_id"
    t.string   "readable_type", null: false
    t.integer  "user_id",       null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["user_id", "readable_type", "readable_id"], name: "index_read_marks_on_user_id_and_readable_type_and_readable_id", using: :btree

  create_table "request_categories", force: :cascade do |t|
    t.integer  "service_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "request_categories", ["service_category_id"], name: "index_request_categories_on_service_category_id", using: :btree

  create_table "request_confirmation_fields", force: :cascade do |t|
    t.string   "name"
    t.string   "field_type"
    t.boolean  "required"
    t.integer  "request_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "request_confirmation_fields", ["request_category_id"], name: "index_request_confirmation_fields_on_request_category_id", using: :btree

  create_table "request_fields", force: :cascade do |t|
    t.string   "name"
    t.string   "field_type"
    t.boolean  "required"
    t.integer  "request_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "request_fields", ["request_category_id"], name: "index_request_fields_on_request_category_id", using: :btree

  create_table "request_products", force: :cascade do |t|
    t.integer  "request_id"
    t.integer  "product_service_id"
    t.integer  "quantity"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "request_products", ["product_service_id"], name: "index_request_products_on_product_service_id", using: :btree
  add_index "request_products", ["request_id"], name: "index_request_products_on_request_id", using: :btree

  create_table "requests", force: :cascade do |t|
    t.integer  "request_category_id"
    t.integer  "user_id"
    t.integer  "service_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.hstore   "properties"
    t.hstore   "confirmation_properties"
  end

  add_index "requests", ["confirmation_properties"], name: "requests_confirmation_properties", using: :gin
  add_index "requests", ["properties"], name: "requests_properties", using: :gin
  add_index "requests", ["request_category_id"], name: "index_requests_on_request_category_id", using: :btree
  add_index "requests", ["service_id"], name: "index_requests_on_service_id", using: :btree
  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "service_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "has_product"
  end

  create_table "service_fields", force: :cascade do |t|
    t.string   "name"
    t.string   "field_type"
    t.boolean  "required"
    t.integer  "service_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "service_fields", ["service_category_id"], name: "index_service_fields_on_service_category_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.integer "user_id"
    t.integer "service_category_id"
    t.string  "title"
    t.text    "description"
    t.string  "avatar"
    t.hstore  "properties"
    t.string  "address"
    t.float   "latitude"
    t.float   "longitude"
    t.integer "rate_price"
  end

  add_index "services", ["properties"], name: "services_properties", using: :gin

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address_line_1"
    t.text     "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "phone_number"
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "pinterest"
    t.string   "instagram"
    t.string   "provider"
    t.string   "uid"
    t.string   "remote_image_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "verify_users", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "foto_ktp"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_verify",  default: false
  end

  add_index "verify_users", ["user_id"], name: "index_verify_users_on_user_id", using: :btree

  create_table "withdraws", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "money"
    t.integer  "billing_id"
    t.integer  "bank_name_id"
    t.string   "account_name"
    t.boolean  "has_billing",    default: false
    t.boolean  "status",         default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "account_number"
    t.string   "branch"
    t.string   "city"
  end

  add_index "withdraws", ["bank_name_id"], name: "index_withdraws_on_bank_name_id", using: :btree
  add_index "withdraws", ["billing_id"], name: "index_withdraws_on_billing_id", using: :btree
  add_index "withdraws", ["user_id"], name: "index_withdraws_on_user_id", using: :btree

  add_foreign_key "balances", "users"
  add_foreign_key "billings", "bank_names"
  add_foreign_key "complaint_services", "services"
  add_foreign_key "confirmation_deposits", "bank_names"
  add_foreign_key "confirmation_deposits", "deposits"
  add_foreign_key "confirmation_deposits", "users"
  add_foreign_key "confirmation_request_products", "request_products"
  add_foreign_key "confirmation_requests", "requests"
  add_foreign_key "deposits", "users"
  add_foreign_key "feedbacks", "services"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "foto_product_services", "product_services"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "order_coupons", "coupons"
  add_foreign_key "order_coupons", "users"
  add_foreign_key "product_services", "services"
  add_foreign_key "request_categories", "service_categories"
  add_foreign_key "request_confirmation_fields", "request_categories"
  add_foreign_key "request_fields", "request_categories"
  add_foreign_key "request_products", "product_services"
  add_foreign_key "request_products", "requests"
  add_foreign_key "requests", "request_categories"
  add_foreign_key "requests", "services"
  add_foreign_key "requests", "users"
  add_foreign_key "service_fields", "service_categories"
  add_foreign_key "verify_users", "users"
  add_foreign_key "withdraws", "bank_names"
  add_foreign_key "withdraws", "billings"
  add_foreign_key "withdraws", "users"
end
