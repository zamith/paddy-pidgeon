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

ActiveRecord::Schema.define(:version => 20120905143659) do

  create_table "citygate_authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
    t.string   "name"
    t.string   "link"
    t.string   "image_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "citygate_permissions", :force => true do |t|
    t.string  "action",        :null => false
    t.string  "subject_class", :null => false
    t.string  "subject_id"
    t.integer "role_id"
  end

  add_index "citygate_permissions", ["role_id"], :name => "index_citygate_permissions_on_role_id"

  create_table "citygate_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "citygate_users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "password_salt"
    t.integer  "role_id"
  end

  add_index "citygate_users", ["confirmation_token"], :name => "index_citygate_users_on_confirmation_token", :unique => true
  add_index "citygate_users", ["email"], :name => "index_citygate_users_on_email", :unique => true
  add_index "citygate_users", ["invitation_token"], :name => "index_citygate_users_on_invitation_token"
  add_index "citygate_users", ["invited_by_id"], :name => "index_citygate_users_on_invited_by_id"
  add_index "citygate_users", ["reset_password_token"], :name => "index_citygate_users_on_reset_password_token", :unique => true

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "finish_date"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "groups", ["user_id"], :name => "index_groups_on_user_id"

  create_table "groups_people", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "person_id"
  end

  add_index "groups_people", ["group_id", "person_id"], :name => "index_groups_people_on_group_id_and_person_id"
  add_index "groups_people", ["person_id", "group_id"], :name => "index_groups_people_on_person_id_and_group_id"

  create_table "messages", :force => true do |t|
    t.text     "text"
    t.integer  "event_id"
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "deliver_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "messages", ["event_id"], :name => "index_messages_on_event_id"
  add_index "messages", ["group_id"], :name => "index_messages_on_group_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_no"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "people", ["user_id"], :name => "index_people_on_user_id"

end
