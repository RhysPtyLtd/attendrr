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

ActiveRecord::Schema.define(version: 2020_05_08_064523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.integer "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_activities_on_club_id"
  end

  create_table "attendances", id: :serial, force: :cascade do |t|
    t.integer "student_id"
    t.integer "activity_id"
    t.integer "timeslot_id"
    t.datetime "attended_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "attended"
    t.integer "rank_id"
    t.index ["activity_id"], name: "index_attendances_on_activity_id"
    t.index ["rank_id"], name: "index_attendances_on_rank_id"
    t.index ["student_id"], name: "index_attendances_on_student_id"
    t.index ["timeslot_id"], name: "index_attendances_on_timeslot_id"
  end

  create_table "clubs", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.integer "postcode"
    t.string "country"
    t.string "phone1"
    t.string "phone2"
    t.string "owner_first_name"
    t.string "owner_last_name"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "picture"
    t.integer "absent_alert", default: 14
    t.bigint "subscription_id"
    t.string "stripe_subscription_id"
    t.index ["email"], name: "index_clubs_on_email", unique: true
    t.index ["subscription_id"], name: "index_clubs_on_subscription_id"
  end

  create_table "daily_financial_reports", id: :serial, force: :cascade do |t|
    t.integer "club_id"
    t.integer "student_id"
    t.integer "payment_plan_id"
    t.decimal "price"
    t.string "regularity"
    t.float "daily_value"
    t.boolean "reccuring"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_daily_financial_reports_on_club_id"
    t.index ["payment_plan_id"], name: "index_daily_financial_reports_on_payment_plan_id"
    t.index ["student_id"], name: "index_daily_financial_reports_on_student_id"
  end

  create_table "daily_metrics", force: :cascade do |t|
    t.integer "total_active_students"
    t.integer "lost_students"
    t.integer "new_students"
    t.bigint "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "revenue"
    t.index ["club_id"], name: "index_daily_metrics_on_club_id"
  end

  create_table "payment_plans", id: :serial, force: :cascade do |t|
    t.integer "club_id"
    t.string "name"
    t.decimal "price", precision: 8, scale: 2
    t.string "frequency"
    t.boolean "active", default: true
    t.integer "classes_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "daily_value"
    t.index ["club_id"], name: "index_payment_plans_on_club_id"
  end

  create_table "ranks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.integer "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["activity_id"], name: "index_ranks_on_activity_id"
  end

  create_table "student_ranks", id: :serial, force: :cascade do |t|
    t.integer "student_id"
    t.integer "rank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["rank_id"], name: "index_student_ranks_on_rank_id"
    t.index ["student_id"], name: "index_student_ranks_on_student_id"
  end

  create_table "students", id: :serial, force: :cascade do |t|
    t.integer "club_id"
    t.string "email"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.integer "postcode"
    t.string "phone1"
    t.string "phone2"
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.integer "payment_plan_id"
    t.string "parent1"
    t.string "parent2"
    t.string "size"
    t.text "notes"
    t.boolean "active", default: true
    t.integer "classes_remaining"
    t.index ["club_id"], name: "index_students_on_club_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "cost"
    t.integer "student_limit"
    t.string "stripe_id"
    t.string "description"
  end

  create_table "timeslots", id: :serial, force: :cascade do |t|
    t.time "time_start"
    t.time "time_end"
    t.integer "day"
    t.integer "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.datetime "schedule"
    t.index ["activity_id"], name: "index_timeslots_on_activity_id"
  end

  add_foreign_key "activities", "clubs"
  add_foreign_key "attendances", "activities"
  add_foreign_key "attendances", "students"
  add_foreign_key "attendances", "timeslots"
  add_foreign_key "clubs", "subscriptions"
  add_foreign_key "daily_financial_reports", "clubs"
  add_foreign_key "daily_financial_reports", "payment_plans"
  add_foreign_key "daily_financial_reports", "students"
  add_foreign_key "daily_metrics", "clubs"
  add_foreign_key "payment_plans", "clubs"
  add_foreign_key "ranks", "activities"
  add_foreign_key "student_ranks", "ranks"
  add_foreign_key "student_ranks", "students"
  add_foreign_key "students", "clubs"
  add_foreign_key "timeslots", "activities"
end
