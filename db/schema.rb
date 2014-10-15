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

ActiveRecord::Schema.define(version: 20141015162817) do

  create_table "reminder_rules", force: true do |t|
    t.integer  "reminder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day_of_week", limit: 255,                   null: false
    t.string   "time_of_day",             default: "13:37", null: false
    t.text     "schedule"
    t.boolean  "textable",                default: true,    null: false
    t.boolean  "emailable",               default: true,    null: false
  end

  add_index "reminder_rules", ["reminder_id"], name: "index_reminder_rules_on_reminder_id"

  create_table "reminders", force: true do |t|
    t.string   "title",       null: false
    t.string   "time_period"
    t.text     "notes"
    t.datetime "start",       null: false
    t.integer  "doses",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "reminders", ["user_id"], name: "index_reminders_on_user_id"

  create_table "schedule_logs", force: true do |t|
    t.datetime "last_ran"
    t.string   "name"
  end

  add_index "schedule_logs", ["name"], name: "index_schedule_logs_on_name"

  create_table "users", force: true do |t|
    t.string   "email",                            default: "",    null: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "admin",                            default: false
    t.integer  "phone",                  limit: 8
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
