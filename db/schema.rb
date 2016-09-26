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

ActiveRecord::Schema.define(version: 20160923140817) do

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.integer  "club_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["club_id"], name: "index_activities_on_club_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.integer  "postcode"
    t.string   "country"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "owner_first_name"
    t.string   "owner_last_name"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "picture"
    t.index ["email"], name: "index_clubs_on_email", unique: true
  end

  create_table "students", force: :cascade do |t|
    t.integer  "club_id"
    t.string   "email"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.integer  "postcode"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "parent1_first_name"
    t.string   "parent1_last_name"
    t.string   "parent2_first_name"
    t.string   "parent2_last_name"
    t.date     "dob"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "picture"
    t.index ["club_id"], name: "index_students_on_club_id"
  end

  create_table "timeslots", force: :cascade do |t|
    t.time     "time_start"
    t.time     "time_end"
    t.integer  "day"
    t.integer  "activity_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "active",      default: true
    t.index ["activity_id"], name: "index_timeslots_on_activity_id"
  end

end
