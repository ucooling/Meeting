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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130822030019) do

  create_table "b_departments", :force => true do |t|
    t.integer  "key"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "d_departments", :force => true do |t|
    t.integer  "key"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "positions", :force => true do |t|
    t.integer  "key"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "room_name"
    t.integer  "room_floor"
    t.string   "tv_ip"
    t.boolean  "tv"
    t.boolean  "projector"
    t.boolean  "pc"
    t.boolean  "webcam"
    t.boolean  "tel"
    t.boolean  "sound_proofing"
    t.boolean  "air_condition"
    t.boolean  "whiteboard"
    t.integer  "max_volume"
    t.string   "tel_num"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "schedule_id"
  end

  create_table "schedules", :force => true do |t|
    t.integer  "room_id"
    t.integer  "user_id"
    t.string   "schedule_day"
    t.string   "start_time"
    t.string   "end_time"
    t.text     "comment"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "title"
  end

  create_table "statuses", :force => true do |t|
    t.string   "room_name"
    t.string   "schedule_day"
    t.string   "start_time"
    t.string   "end_time"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "scheduleid"
  end

  create_table "user_types", :force => true do |t|
    t.integer  "key"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "number"
    t.string   "name"
    t.string   "email"
    t.string   "tel"
    t.integer  "b_department"
    t.integer  "d_department"
    t.integer  "position"
    t.integer  "user_type"
    t.string   "password"
    t.boolean  "admin"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "schedule_id"
    t.boolean  "superuser"
  end

end
