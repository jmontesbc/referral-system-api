# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_05_225407) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "view_id", null: false
    t.bigint "action_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action_id"], name: "index_permissions_on_action_id"
    t.index ["user_id"], name: "index_permissions_on_user_id"
    t.index ["view_id"], name: "index_permissions_on_view_id"
  end

  create_table "pos_ref_histories", force: :cascade do |t|
    t.bigint "positions_referral_id", null: false
    t.bigint "position_referral_status_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["position_referral_status_id"], name: "index_pos_ref_histories_on_position_referral_status_id"
    t.index ["positions_referral_id"], name: "index_pos_ref_histories_on_positions_referral_id"
    t.index ["user_id"], name: "index_pos_ref_histories_on_user_id"
  end

  create_table "position_referral_statuses", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "positions_referrals", force: :cascade do |t|
    t.bigint "referral_id", null: false
    t.datetime "signed_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["referral_id"], name: "index_positions_referrals_on_referral_id"
  end

  create_table "referrals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name"
    t.string "given_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.string "linkedin_url"
    t.string "cv_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_referrals_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.bigint "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "views", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "permissions", "actions"
  add_foreign_key "permissions", "users"
  add_foreign_key "permissions", "views"
  add_foreign_key "pos_ref_histories", "position_referral_statuses"
  add_foreign_key "pos_ref_histories", "positions_referrals"
  add_foreign_key "pos_ref_histories", "users"
  add_foreign_key "positions_referrals", "referrals"
  add_foreign_key "referrals", "users"
  add_foreign_key "users", "roles"
end
