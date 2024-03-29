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

ActiveRecord::Schema.define(:version => 20120606131921) do

  create_table "deploys", :force => true do |t|
    t.integer  "service_id"
    t.string   "commit"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "machines", :force => true do |t|
    t.string   "type"
    t.string   "tag"
    t.string   "ip_address"
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ports", :force => true do |t|
    t.integer  "machine_id"
    t.integer  "service_id"
    t.integer  "port"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "provisions", :force => true do |t|
    t.integer  "machine_id"
    t.integer  "service_id"
    t.integer  "start_port"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "resources", :force => true do |t|
    t.string   "type"
    t.integer  "service_id"
    t.text     "data"
    t.integer  "machine_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "repo"
    t.string   "state"
    t.string   "stack"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
