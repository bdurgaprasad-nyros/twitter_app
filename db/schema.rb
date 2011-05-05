# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110503115017) do

  create_table "members", :force => true do |t|
    t.integer  "twitter_id",        :limit => 8, :null => false
    t.string   "screen_name"
    t.string   "token"
    t.string   "secret"
    t.string   "profile_image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "friends_count"
    t.integer  "followers_count"
    t.integer  "statuses_count"
  end

  add_index "members", ["screen_name"], :name => "index_members_on_screen_name", :unique => true
  add_index "members", ["twitter_id"], :name => "index_members_on_twitter_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "screen_name"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
