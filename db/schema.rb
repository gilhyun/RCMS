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

ActiveRecord::Schema.define(:version => 20130311075519) do

  create_table "attachfiles", :force => true do |t|
    t.integer  "document_id", :null => false
    t.string   "filename",    :null => false
    t.string   "filepath"
    t.integer  "filesize",    :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "categories", :force => true do |t|
    t.integer  "document_id", :null => false
    t.string   "name",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "document_id", :null => false
    t.integer  "version",     :null => false
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "documents", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "attachfile_id"
    t.integer  "groupid",                          :null => false
    t.integer  "version",                          :null => false
    t.boolean  "published",     :default => false
    t.string   "title",                            :null => false
    t.text     "content"
    t.integer  "readcount",     :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "tmpfiles", :force => true do |t|
    t.string   "ufilename"
    t.string   "ufilepath"
    t.string   "filename"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "time_token"
    t.integer  "filesize"
  end

  create_table "users", :force => true do |t|
    t.string   "userid"
    t.string   "email"
    t.boolean  "admin"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "password"
  end

end
