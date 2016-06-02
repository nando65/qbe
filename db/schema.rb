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

ActiveRecord::Schema.define(version: 20160531205741) do

  create_table "advises", force: :cascade do |t|
    t.integer  "gives_advice_to",      limit: 4,     null: false
    t.integer  "receives_advice_from", limit: 4,     null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.text     "advise",               limit: 65535
  end

  create_table "affinities", force: :cascade do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "level",                limit: 4
    t.text     "affinity_description", limit: 65535
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "post_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "commentary", limit: 65535
  end

  create_table "endorsements", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 255
  end

  create_table "endorses", force: :cascade do |t|
    t.integer  "follower_id",    limit: 4, null: false
    t.integer  "subject_id",     limit: 4, null: false
    t.integer  "endorsement_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "weight",         limit: 4
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "follower_id", limit: 4, null: false
    t.integer  "subject_id",  limit: 4, null: false
    t.integer  "affinity_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "weight",      limit: 4
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "post_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "comment_id", limit: 4
  end

  create_table "locations", force: :cascade do |t|
    t.string   "address",    limit: 255
    t.float    "latitude",   limit: 24
    t.float    "longitude",  limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "title",              limit: 255
    t.text     "subtitle",           limit: 65535
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "notification_type",  limit: 4
    t.integer  "endorse_weight",     limit: 4
    t.integer  "follower_id",        limit: 4
    t.boolean  "unread",                           default: true
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "title",               limit: 255
    t.string   "subtitle",            limit: 255
    t.string   "image_file_name",     limit: 255
    t.string   "image_content_type",  limit: 255
    t.integer  "image_file_size",     limit: 4
    t.datetime "image_updated_at"
    t.integer  "post_type",           limit: 4
    t.boolean  "shared_post"
    t.string   "person_sharing",      limit: 255
    t.integer  "person_sharing_id",   limit: 4
    t.integer  "follower_id",         limit: 4
    t.integer  "original_owner_id",   limit: 4
    t.string   "original_owner_name", limit: 255
  end

  create_table "privacies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "problems", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "problem",    limit: 65535
  end

  create_table "terms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                        limit: 255,   default: "",     null: false
    t.string   "encrypted_password",           limit: 255,   default: "",     null: false
    t.string   "reset_password_token",         limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                limit: 4,     default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",           limit: 255
    t.string   "last_sign_in_ip",              limit: 255
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "first_name",                   limit: 255
    t.string   "last_name",                    limit: 255
    t.string   "profile_picture_file_name",    limit: 255
    t.string   "profile_picture_content_type", limit: 255
    t.integer  "profile_picture_file_size",    limit: 4
    t.datetime "profile_picture_updated_at"
    t.string   "city",                         limit: 255
    t.string   "country",                      limit: 255
    t.string   "job_title",                    limit: 255
    t.string   "company_name",                 limit: 255
    t.boolean  "active_location"
    t.boolean  "private_advise",                             default: true
    t.string   "facebook_id",                  limit: 255
    t.text     "biography",                    limit: 65535
    t.string   "phone",                        limit: 255
    t.date     "birthdate"
    t.string   "gender",                       limit: 255,   default: "male"
    t.string   "facebook_link",                limit: 255
    t.string   "fb_token",                     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "provider",                     limit: 255
    t.string   "uid",                          limit: 255
    t.float    "latitude",                     limit: 24
    t.float    "longitude",                    limit: 24
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
