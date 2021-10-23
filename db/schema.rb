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

ActiveRecord::Schema.define(version: 2021_10_23_194119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "school_id", null: false
    t.boolean "permitted", default: false
    t.string "role", default: "admin"
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_admins_on_school_id"
    t.index ["uid", "provider"], name: "index_admins_on_uid_and_provider", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.text "body"
    t.text "image_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.boolean "present"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "behaviour_reports", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "student_id", null: false
    t.bigint "teacher_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "behaviour_type"
    t.index ["student_id"], name: "index_behaviour_reports_on_student_id"
    t.index ["teacher_id"], name: "index_behaviour_reports_on_teacher_id"
  end

  create_table "bill_reports", force: :cascade do |t|
    t.string "title"
    t.integer "amount"
    t.bigint "school_id", null: false
    t.bigint "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "optional", default: false
    t.index ["admin_id"], name: "index_bill_reports_on_admin_id"
    t.index ["school_id"], name: "index_bill_reports_on_school_id"
  end

  create_table "bills", force: :cascade do |t|
    t.boolean "payment_completed", default: false
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "bill_report_id"
    t.integer "paid", default: 0
    t.integer "balance", default: 0
    t.boolean "optional", default: false
    t.index ["bill_report_id"], name: "index_bills_on_bill_report_id"
    t.index ["student_id"], name: "index_bills_on_student_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.bigint "school_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["school_id"], name: "index_classrooms_on_school_id"
  end

  create_table "debt_recovered_reports", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.bigint "admin_id", null: false
    t.bigint "bill_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "amount"
    t.index ["admin_id"], name: "index_debt_recovered_reports_on_admin_id"
    t.index ["bill_id"], name: "index_debt_recovered_reports_on_bill_id"
    t.index ["school_id"], name: "index_debt_recovered_reports_on_school_id"
  end

  create_table "expense_reports", force: :cascade do |t|
    t.integer "amount"
    t.string "title"
    t.bigint "school_id", null: false
    t.bigint "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_expense_reports_on_admin_id"
    t.index ["school_id"], name: "index_expense_reports_on_school_id"
  end

  create_table "guidances", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_guidances_on_confirmation_token", unique: true
    t.index ["email"], name: "index_guidances_on_email", unique: true
    t.index ["reset_password_token"], name: "index_guidances_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_guidances_on_uid_and_provider", unique: true
  end

  create_table "guidances_students", id: false, force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "guidance_id", null: false
    t.index ["guidance_id", "student_id"], name: "index_guidances_students_on_guidance_id_and_student_id"
    t.index ["student_id", "guidance_id"], name: "index_guidances_students_on_student_id_and_guidance_id"
  end

  create_table "item_solds", force: :cascade do |t|
    t.bigint "sale_report_id", null: false
    t.bigint "item_id", null: false
    t.integer "quantity"
    t.integer "total", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_item_solds_on_item_id"
    t.index ["sale_report_id"], name: "index_item_solds_on_sale_report_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.bigint "school_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "selling_price"
    t.integer "quantity", default: 0
    t.index ["school_id"], name: "index_items_on_school_id"
  end

  create_table "payment_histories", force: :cascade do |t|
    t.integer "amount"
    t.bigint "bill_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bill_id"], name: "index_payment_histories_on_bill_id"
  end

  create_table "restock_reports", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "school_id", null: false
    t.bigint "admin_id", null: false
    t.index ["admin_id"], name: "index_restock_reports_on_admin_id"
    t.index ["item_id"], name: "index_restock_reports_on_item_id"
    t.index ["school_id"], name: "index_restock_reports_on_school_id"
  end

  create_table "sale_reports", force: :cascade do |t|
    t.integer "total"
    t.bigint "school_id", null: false
    t.bigint "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_sale_reports_on_admin_id"
    t.index ["school_id"], name: "index_sale_reports_on_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_schools_on_name", unique: true
  end

  create_table "score_report_drafts", force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.bigint "teacher_id", null: false
    t.bigint "score_type_id", null: false
    t.boolean "published", default: false
    t.integer "max"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["score_type_id"], name: "index_score_report_drafts_on_score_type_id"
    t.index ["subject_id"], name: "index_score_report_drafts_on_subject_id"
    t.index ["teacher_id"], name: "index_score_report_drafts_on_teacher_id"
  end

  create_table "score_reports", force: :cascade do |t|
    t.integer "max"
    t.integer "score"
    t.string "remark"
    t.bigint "teacher_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "subject_id", null: false
    t.bigint "student_id", null: false
    t.bigint "score_type_id", null: false
    t.index ["score_type_id"], name: "index_score_reports_on_score_type_id"
    t.index ["student_id"], name: "index_score_reports_on_student_id"
    t.index ["subject_id"], name: "index_score_reports_on_subject_id"
    t.index ["teacher_id"], name: "index_score_reports_on_teacher_id"
  end

  create_table "score_types", force: :cascade do |t|
    t.string "name"
    t.bigint "school_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["school_id"], name: "index_score_types_on_school_id"
  end

  create_table "stock_repair_reports", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "school_id", null: false
    t.bigint "admin_id", null: false
    t.index ["admin_id"], name: "index_stock_repair_reports_on_admin_id"
    t.index ["item_id"], name: "index_stock_repair_reports_on_item_id"
    t.index ["school_id"], name: "index_stock_repair_reports_on_school_id"
  end

  create_table "student_score_report_drafts", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.integer "score", default: 0
    t.boolean "scored", default: false
    t.bigint "score_report_draft_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["score_report_draft_id"], name: "index_student_score_report_drafts_on_score_report_draft_id"
    t.index ["student_id"], name: "index_student_score_report_drafts_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "school_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "full_name"
    t.bigint "classroom_id"
    t.integer "total_debt", default: 0
    t.string "image"
    t.index ["classroom_id"], name: "index_students_on_classroom_id"
    t.index ["confirmation_token"], name: "index_students_on_confirmation_token", unique: true
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_students_on_school_id"
    t.index ["uid", "provider"], name: "index_students_on_uid_and_provider", unique: true
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "teacher_id", null: false
    t.bigint "classroom_id", null: false
    t.index ["classroom_id"], name: "index_subjects_on_classroom_id"
    t.index ["teacher_id"], name: "index_subjects_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "school_id", null: false
    t.string "full_name"
    t.boolean "permitted", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.index ["confirmation_token"], name: "index_teachers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_teachers_on_school_id"
    t.index ["uid", "provider"], name: "index_teachers_on_uid_and_provider", unique: true
  end

  create_table "term_dates", force: :cascade do |t|
    t.string "start_date"
    t.string "end_date"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admins", "schools"
  add_foreign_key "behaviour_reports", "students"
  add_foreign_key "behaviour_reports", "teachers"
  add_foreign_key "bill_reports", "admins"
  add_foreign_key "bill_reports", "schools"
  add_foreign_key "bills", "bill_reports"
  add_foreign_key "bills", "students"
  add_foreign_key "classrooms", "schools"
  add_foreign_key "debt_recovered_reports", "admins"
  add_foreign_key "debt_recovered_reports", "bills"
  add_foreign_key "debt_recovered_reports", "schools"
  add_foreign_key "expense_reports", "admins"
  add_foreign_key "expense_reports", "schools"
  add_foreign_key "item_solds", "items"
  add_foreign_key "item_solds", "sale_reports"
  add_foreign_key "items", "schools"
  add_foreign_key "payment_histories", "bills"
  add_foreign_key "restock_reports", "admins"
  add_foreign_key "restock_reports", "items"
  add_foreign_key "restock_reports", "schools"
  add_foreign_key "sale_reports", "admins"
  add_foreign_key "sale_reports", "schools"
  add_foreign_key "score_report_drafts", "score_types"
  add_foreign_key "score_report_drafts", "subjects"
  add_foreign_key "score_report_drafts", "teachers"
  add_foreign_key "score_reports", "score_types"
  add_foreign_key "score_reports", "students"
  add_foreign_key "score_reports", "subjects"
  add_foreign_key "score_reports", "teachers"
  add_foreign_key "score_types", "schools"
  add_foreign_key "stock_repair_reports", "admins"
  add_foreign_key "stock_repair_reports", "items"
  add_foreign_key "stock_repair_reports", "schools"
  add_foreign_key "student_score_report_drafts", "score_report_drafts"
  add_foreign_key "student_score_report_drafts", "students"
  add_foreign_key "students", "classrooms"
  add_foreign_key "students", "schools"
  add_foreign_key "subjects", "classrooms"
  add_foreign_key "subjects", "teachers"
  add_foreign_key "teachers", "schools"
end
