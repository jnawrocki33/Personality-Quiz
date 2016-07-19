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

ActiveRecord::Schema.define(version: 20160717023510) do

  create_table "options", force: :cascade do |t|
    t.string   "text"
    t.integer  "parent_question"
    t.text     "values"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.integer  "test_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "bio"
    t.integer  "score"
    t.integer  "values_index"
    t.string   "image_path"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "prompt"
    t.integer  "answer"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "test_id"
    t.integer  "survey_id"
    t.         "isDup"
    t.integer  "cloner_id"
    t.integer  "question_number"
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "test_id"
    t.integer  "question_index"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string   "test_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "question_index"
  end

end
