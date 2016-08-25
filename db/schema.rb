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

ActiveRecord::Schema.define(version: 20160823070914) do

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token", limit: 255
    t.datetime "expires_at"
    t.integer  "user_id",      limit: 4
    t.boolean  "active"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "calendar_users", force: :cascade do |t|
    t.integer "calendar_id", limit: 4
    t.integer "user_id",     limit: 4
    t.integer "status",      limit: 4, default: 0, null: false
  end

  create_table "calendars", force: :cascade do |t|
    t.string   "title",       limit: 255, default: "", null: false
    t.integer  "color_R",     limit: 4
    t.integer  "color_G",     limit: 4
    t.integer  "color_B",     limit: 4
    t.string   "user_id",     limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "stamp_image", limit: 255
  end

  create_table "invitation_users", force: :cascade do |t|
    t.integer  "calendar_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "status",      limit: 4, default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "stamped_dates", force: :cascade do |t|
    t.datetime "date"
    t.integer  "calendar_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "email",            limit: 255, null: false
    t.string   "crypted_password", limit: 255
    t.string   "salt",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar",           limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
