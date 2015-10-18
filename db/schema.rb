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

ActiveRecord::Schema.define(version: 20151009201037) do

  create_table "group_members", force: :cascade do |t|
    t.integer  "groupId"
    t.integer  "userId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.boolean  "open_group"
    t.string   "domain"
    t.boolean  "company"
    t.string   "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "title"
    t.string   "topic"
    t.date     "date"
    t.time     "start_time"
    t.integer  "expected_duration_hr"
    t.integer  "expected_duration_min"
    t.text     "details"
    t.boolean  "cancelled"
    t.integer  "estimated_difficulty"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "tagalong_id"
    t.integer  "owner_stars"
    t.integer  "accuracy_of_event_stars"
    t.text     "review"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "tagalongs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.boolean  "showed_up"
    t.boolean  "approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "email"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.text     "about_me"
    t.date     "date_of_birth"
    t.string   "password_digest"
    t.boolean  "active"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
