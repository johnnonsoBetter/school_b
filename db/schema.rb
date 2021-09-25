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

ActiveRecord::Schema.define(version: 2021_09_25_185835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_admins_on_school_id"
    t.index ["uid", "provider"], name: "index_admins_on_uid_and_provider", unique: true
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

  create_table "bills", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "total_amount"
    t.boolean "payment_completed"
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_bills_on_student_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.bigint "school_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["school_id"], name: "index_classrooms_on_school_id"
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

  create_table "payment_histories", force: :cascade do |t|
    t.integer "amount"
    t.bigint "bill_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bill_id"], name: "index_payment_histories_on_bill_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_schools_on_name", unique: true
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
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "school_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
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
    t.index ["confirmation_token"], name: "index_teachers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_teachers_on_school_id"
    t.index ["uid", "provider"], name: "index_teachers_on_uid_and_provider", unique: true
  end

  add_foreign_key "admins", "schools"
  add_foreign_key "behaviour_reports", "students"
  add_foreign_key "behaviour_reports", "teachers"
  add_foreign_key "bills", "students"
  add_foreign_key "classrooms", "schools"
  add_foreign_key "payment_histories", "bills"
  add_foreign_key "score_reports", "score_types"
  add_foreign_key "score_reports", "students"
  add_foreign_key "score_reports", "subjects"
  add_foreign_key "score_reports", "teachers"
  add_foreign_key "score_types", "schools"
  add_foreign_key "students", "schools"
  add_foreign_key "subjects", "classrooms"
  add_foreign_key "subjects", "teachers"
  add_foreign_key "teachers", "schools"
end
