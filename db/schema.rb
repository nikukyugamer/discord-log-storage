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

ActiveRecord::Schema.define(version: 2021_05_22_035316) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.bigint "id_number", null: false
    t.string "url", default: "_URL_IS_NOTHING_", null: false
    t.string "file_name", default: "_FILE_NAME_IS_NOTHING_", null: false
    t.integer "file_size_bytes", default: 0, null: false
    t.bigint "message_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id_number"], name: "index_attachments_on_id_number", unique: true
    t.index ["message_id"], name: "index_attachments_on_message_id"
  end

  create_table "channels", force: :cascade do |t|
    t.bigint "id_number", null: false
    t.string "type_name", default: "_TYPE_NAME_IS_NOTHING_", null: false
    t.string "category", default: "_CATEGORY_IS_NOTHING_", null: false
    t.string "name", default: "_NAME_IS_NOTHING_", null: false
    t.string "topic", default: "_TOPIC_IS_NOTHING_", null: false
    t.bigint "guild_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guild_id"], name: "index_channels_on_guild_id"
    t.index ["id_number"], name: "index_channels_on_id_number", unique: true
  end

  create_table "embeds", force: :cascade do |t|
    t.string "title", default: "_TITLE_IS_NOTHING_", null: false
    t.string "url", default: "_URL_IS_NOTHING_", null: false
    t.datetime "timestamp", default: "1980-01-01 12:00:00", null: false
    t.string "description", default: "_DESCRIPTION_IS_NOTHING_", null: false
    t.jsonb "thumbnail"
    t.string "fields", default: "_FIELDS_IS_NOTHING_", null: false
    t.bigint "message_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id"], name: "index_embeds_on_message_id"
  end

  create_table "guilds", force: :cascade do |t|
    t.bigint "id_number", null: false
    t.string "name", default: "_NAME_IS_NOTHING_", null: false
    t.string "icon_url", default: "_ICON_URL_IS_NOTHING_", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id_number"], name: "index_guilds_on_id_number", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "id_number", null: false
    t.string "type_name", default: "_TYPE_NAME_IS_NOTHING_", null: false
    t.datetime "timestamp", default: "1980-01-01 12:00:00", null: false
    t.datetime "timestamp_edited", default: "1980-01-01 12:00:00", null: false
    t.datetime "call_end_timestamp", default: "1980-01-01 12:00:00", null: false
    t.boolean "is_pinned", default: false, null: false
    t.string "content", default: "_CONTENT_IS_NOTHING_", null: false
    t.bigint "user_id"
    t.bigint "channel_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_messages_on_channel_id"
    t.index ["id_number"], name: "index_messages_on_id_number", unique: true
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reactions", force: :cascade do |t|
    t.integer "count", default: -1, null: false
    t.jsonb "emoji"
    t.bigint "message_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id"], name: "index_reactions_on_message_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "id_number", default: -1, null: false
    t.string "name", default: "_NAME_IS_NOTHING_", null: false
    t.boolean "is_bot", default: false, null: false
    t.string "discriminator", default: "_DISCRIMINATOR_IS_NOTHING_", null: false
    t.string "nickname", default: "_NICKNAME_IS_NOTHING_", null: false
    t.string "avatar_url", default: "_AVATAR_URL_IS_NOTHING_", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id_number"], name: "index_users_on_id_number", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type"
    t.string "{:null=>false}"
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
