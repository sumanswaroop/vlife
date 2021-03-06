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

ActiveRecord::Schema.define(version: 20161121105030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blobs", primary_key: "med_id", id: :string, force: :cascade do |t|
    t.string   "description"
    t.binary   "content",     null: false
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "friends", force: :cascade do |t|
    t.string   "user_id",                        null: false
    t.string   "friend_id",                      null: false
    t.string   "status",     default: "waiting", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["friend_id"], name: "index_friends_on_friend_id", using: :btree
    t.index ["user_id", "friend_id"], name: "index_friends_on_user_id_and_friend_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_friends_on_user_id", using: :btree
  end

  add_check "friends", "((status)::text = ANY ((ARRAY['waiting'::character varying, 'following'::character varying, 'accepted'::character varying])::text[]))", name: "status_check"

  create_table "group_pages", primary_key: "page_id", id: :string, force: :cascade do |t|
    t.string   "description"
    t.string   "page_pic"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name",        null: false
  end

  create_table "group_users", force: :cascade do |t|
    t.string   "page_id",                  null: false
    t.string   "u_id",                     null: false
    t.string   "status",     default: "P", null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_check "group_users", "((status)::text = ANY ((ARRAY['P'::character varying, 'J'::character varying, 'A'::character varying, 'I'::character varying])::text[]))", name: "status_check"

  create_table "institutions", primary_key: "ins_id", id: :string, force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "last_msg_to_users", primary_key: "u_id", id: :string, force: :cascade do |t|
    t.string   "msg_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "country",    null: false
    t.string   "state"
    t.string   "city",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country", "city"], name: "index_locations_on_country_and_city", using: :btree
    t.index ["country", "state", "city"], name: "index_locations_on_country_and_state_and_city", using: :btree
    t.index ["country"], name: "index_locations_on_country", using: :btree
  end

  create_table "messages", primary_key: "msg_id", id: :string, force: :cascade do |t|
    t.string   "content"
    t.string   "sender",     null: false
    t.string   "receiver",   null: false
    t.string   "med_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
  end

  create_table "notifications", primary_key: "not_id", id: :string, force: :cascade do |t|
    t.string   "content",    null: false
    t.string   "eve_id"
    t.string   "p_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "page_id"
    t.string   "slam_id"
  end

  create_table "notify_tos", force: :cascade do |t|
    t.string   "not_id",     null: false
    t.string   "from_id",    null: false
    t.string   "to_id",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status",     null: false
    t.index ["not_id", "from_id", "to_id"], name: "index_notify_tos_on_not_id_and_from_id_and_to_id", using: :btree
    t.index ["to_id"], name: "index_notify_tos_on_to_id", using: :btree
  end

  create_table "post_likes", force: :cascade do |t|
    t.string   "p_id",       null: false
    t.string   "u_id",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["p_id", "u_id"], name: "index_post_likes_on_p_id_and_u_id", unique: true, using: :btree
    t.index ["p_id"], name: "index_post_likes_on_p_id", using: :btree
    t.index ["u_id"], name: "index_post_likes_on_u_id", using: :btree
  end

  create_table "posts", primary_key: "p_id", id: :string, force: :cascade do |t|
    t.string   "content"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "posted_by_id"
    t.string   "media_id"
    t.string   "posted_to_id"
    t.string   "page_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "parent_id"
  end

  add_check "posts", "((posted_to_id IS NOT NULL) OR (posted_by_id IS NOT NULL))", name: "post_to_psge_or_user_check"
  add_check "posts", "((content IS NOT NULL) OR (media_id IS NOT NULL))", name: "content_or_media_check"

  create_table "questions", primary_key: "q_id", id: :string, force: :cascade do |t|
    t.string   "question_description", null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "slam_quests", force: :cascade do |t|
    t.string   "slam_id",    null: false
    t.string   "q_id",       null: false
    t.text     "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slam_id", "q_id"], name: "index_slam_quests_on_slam_id_and_q_id", unique: true, using: :btree
    t.index ["slam_id"], name: "index_slam_quests_on_slam_id", using: :btree
  end

  create_table "slams", primary_key: "slam_id", id: :string, force: :cascade do |t|
    t.string   "filled_by",  null: false
    t.string   "filled_for", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filled_by", "filled_for"], name: "index_slams_on_filled_by_and_filled_for", unique: true, using: :btree
    t.index ["filled_by"], name: "index_slams_on_filled_by", using: :btree
    t.index ["filled_for"], name: "index_slams_on_filled_for", using: :btree
  end

  create_table "user_institutions", force: :cascade do |t|
    t.string   "u_id",       null: false
    t.string   "ins_id",     null: false
    t.date     "start"
    t.date     "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ins_id"], name: "index_user_institutions_on_ins_id", using: :btree
    t.index ["u_id", "ins_id"], name: "index_user_institutions_on_u_id_and_ins_id", unique: true, using: :btree
    t.index ["u_id"], name: "index_user_institutions_on_u_id", using: :btree
  end

  create_table "user_profiles", primary_key: "u_id", id: :string, force: :cascade do |t|
    t.string   "first_name",                null: false
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "gender",                    null: false
    t.string   "language"
    t.date     "birthday",                  null: false
    t.string   "rel_status"
    t.string   "privacy",     default: "O", null: false
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "profile_pic"
  end

  add_check "user_profiles", "((gender)::text = ANY ((ARRAY['M'::character varying, 'F'::character varying, 'O'::character varying])::text[]))", name: "gender_check"
  add_check "user_profiles", "((privacy)::text = ANY ((ARRAY['O'::character varying, 'F'::character varying, 'C'::character varying])::text[]))", name: "privacy_check"
  add_check "user_profiles", "(birthday < now())", name: "birthday_check"

  create_table "users", primary_key: "u_id", id: :string, force: :cascade do |t|
    t.string   "email",                          null: false
    t.string   "phone_no",                       null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "remember_digest"
    t.string   "password_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "status",          default: true
    t.datetime "last_online"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["phone_no"], name: "index_users_on_phone_no", unique: true, using: :btree
  end

  add_foreign_key "friends", "users", column: "friend_id", primary_key: "u_id", name: "friends_friend_id_fkey"
  add_foreign_key "friends", "users", primary_key: "u_id", name: "friends_user_id_fkey"
  add_foreign_key "group_pages", "blobs", column: "page_pic", primary_key: "med_id", name: "group_pages_page_pic_fkey"
  add_foreign_key "group_users", "group_pages", column: "page_id", primary_key: "page_id", name: "group_users_page_id_fkey"
  add_foreign_key "group_users", "users", column: "u_id", primary_key: "u_id", name: "group_users_u_id_fkey"
  add_foreign_key "last_msg_to_users", "messages", column: "msg_id", primary_key: "msg_id", name: "last_msg_to_users_msg_id_fkey"
  add_foreign_key "last_msg_to_users", "users", column: "u_id", primary_key: "u_id", name: "last_msg_to_users_u_id_fkey"
  add_foreign_key "messages", "blobs", column: "med_id", primary_key: "med_id", name: "messages_med_id_fkey"
  add_foreign_key "messages", "users", column: "receiver", primary_key: "u_id", name: "messages_receiver_fkey"
  add_foreign_key "messages", "users", column: "sender", primary_key: "u_id", name: "messages_sender_fkey"
  add_foreign_key "notifications", "group_pages", column: "page_id", primary_key: "page_id", name: "notifications_page_id_fkey"
  add_foreign_key "notifications", "posts", column: "p_id", primary_key: "p_id", name: "notifications_p_id_fkey"
  add_foreign_key "notifications", "slams", primary_key: "slam_id", name: "notifications_slam_id_fkey"
  add_foreign_key "notify_tos", "notifications", column: "not_id", primary_key: "not_id", name: "notify_tos_not_id_fkey"
  add_foreign_key "notify_tos", "users", column: "from_id", primary_key: "u_id", name: "notify_tos_from_id_fkey"
  add_foreign_key "notify_tos", "users", column: "to_id", primary_key: "u_id", name: "notify_tos_to_id_fkey"
  add_foreign_key "post_likes", "posts", column: "p_id", primary_key: "p_id", name: "post_likes_p_id_fkey"
  add_foreign_key "post_likes", "users", column: "u_id", primary_key: "u_id", name: "post_likes_u_id_fkey"
  add_foreign_key "posts", "blobs", column: "media_id", primary_key: "med_id", name: "posts_media_id_fkey"
  add_foreign_key "posts", "posts", column: "parent_id", primary_key: "p_id", name: "posts_parent_id_fkey"
  add_foreign_key "posts", "users", column: "posted_by_id", primary_key: "u_id", name: "posts_posted_by_id_fkey"
  add_foreign_key "posts", "users", column: "posted_to_id", primary_key: "u_id", name: "posts_posted_to_id_fkey"
  add_foreign_key "slam_quests", "questions", column: "q_id", primary_key: "q_id", name: "slam_quests_q_id_fkey"
  add_foreign_key "slam_quests", "slams", primary_key: "slam_id", name: "slam_quests_slam_id_fkey"
  add_foreign_key "slams", "users", column: "filled_by", primary_key: "u_id", name: "slams_filled_by_fkey"
  add_foreign_key "slams", "users", column: "filled_for", primary_key: "u_id", name: "slams_filled_for_fkey"
  add_foreign_key "user_institutions", "institutions", column: "ins_id", primary_key: "ins_id", name: "user_institutions_ins_id_fkey"
  add_foreign_key "user_institutions", "users", column: "u_id", primary_key: "u_id", name: "user_institutions_u_id_fkey"
  add_foreign_key "user_profiles", "blobs", column: "profile_pic", primary_key: "med_id", name: "user_profiles_profile_pic_fkey"
  add_foreign_key "user_profiles", "users", column: "u_id", primary_key: "u_id", name: "user_profiles_u_id_fkey"
end
