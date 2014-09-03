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

ActiveRecord::Schema.define(version: 20140903174414) do

  create_table "reminder_items", force: true do |t|
    t.boolean  "taken"
    t.boolean  "missed"
    t.integer  "reminder_id_id"
    t.datetime "scheduled_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reminder_items", ["reminder_id_id"], name: "index_reminder_items_on_reminder_id_id"

  create_table "reminders", force: true do |t|
    t.string   "title"
    t.integer  "num_per"
    t.string   "time_period"
    t.text     "notes"
    t.datetime "start"
    t.integer  "doses"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
