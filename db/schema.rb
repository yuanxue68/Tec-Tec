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

ActiveRecord::Schema.define(version: 20160306043048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: :cascade do |t|
    t.string   "name",                         null: false
    t.text     "description"
    t.string   "course_code"
    t.string   "school"
    t.float    "starting_price", default: 0.0
    t.float    "buyout_price"
    t.datetime "start_time",                   null: false
    t.datetime "end_time",                     null: false
    t.integer  "owner_id"
    t.integer  "winner_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "picture"
  end

  add_index "auctions", ["end_time"], name: "index_auctions_on_end_time", using: :btree
  add_index "auctions", ["owner_id", "end_time"], name: "index_auctions_on_owner_id_and_end_time", using: :btree
  add_index "auctions", ["owner_id"], name: "index_auctions_on_owner_id", using: :btree
  add_index "auctions", ["winner_id"], name: "index_auctions_on_winner_id", using: :btree

  create_table "bids", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "auction_id"
    t.float    "bid_amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bids", ["auction_id"], name: "index_bids_on_auction_id", using: :btree
  add_index "bids", ["created_at"], name: "index_bids_on_created_at", using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "auction_id"
    t.string   "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["auction_id"], name: "index_comments_on_auction_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "auctions", "users", column: "owner_id"
  add_foreign_key "auctions", "users", column: "winner_id"
end
