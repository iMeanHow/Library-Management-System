# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_02_000536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "time"
    t.string "book_title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "book_histories", force: :cascade do |t|
    t.string "book_isbn"
    t.boolean "is_returned"
    t.string "book_title"
    t.string "student_name"
    t.string "student_email"
    t.time "borrow_time"
    t.time "return_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "library"
  end

  create_table "book_requests", force: :cascade do |t|
    t.string "book_isbn"
    t.boolean "is_delete"
    t.boolean "is_accomplished"
    t.string "book_title"
    t.string "student_name"
    t.string "student_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "library"
  end

  create_table "book_searches", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "isbn"
    t.string "authors"
    t.string "language"
    t.string "edition"
    t.string "published_time"
    t.string "subject"
    t.string "image"
    t.string "summary"
    t.boolean "is_special"
    t.boolean "is_delete"
    t.integer "nums_total"
    t.integer "nums_borrowed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.string "commenter"
    t.text "body"
    t.bigint "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_comments_on_admin_id"
  end

  create_table "librarians", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.integer "max_borrow"
    t.integer "overdue_fine"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "university"
  end

  create_table "students", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "library"
    t.integer "fine"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "education_level"
    t.integer "borrow_num"
    t.boolean "librariansrequest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "admins"
end
