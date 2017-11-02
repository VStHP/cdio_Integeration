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

ActiveRecord::Schema.define(version: 20171027013444) do

  create_table "course_subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "course_id"
    t.bigint "subject_id"
    t.integer "status", default: 0
    t.date "date_start"
    t.date "date_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "subject_id"], name: "index_course_subjects_on_course_id_and_subject_id", unique: true
    t.index ["course_id"], name: "index_course_subjects_on_course_id"
    t.index ["subject_id"], name: "index_course_subjects_on_subject_id"
  end

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "description"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "description"
    t.string "teacher"
    t.integer "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "description"
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_tasks_on_subject_id"
  end

  create_table "user_courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "user_id"], name: "index_user_courses_on_course_id_and_user_id", unique: true
    t.index ["course_id"], name: "index_user_courses_on_course_id"
    t.index ["user_id"], name: "index_user_courses_on_user_id"
  end

  create_table "user_subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "course_subject_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_subject_id"], name: "index_user_subjects_on_course_subject_id"
    t.index ["user_id", "course_subject_id"], name: "index_user_subjects_on_user_id_and_course_subject_id", unique: true
    t.index ["user_id"], name: "index_user_subjects_on_user_id"
  end

  create_table "user_tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_subject_id"
    t.bigint "task_id"
    t.integer "status", default: 0
    t.date "date_receive"
    t.date "date_finish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_user_tasks_on_task_id"
    t.index ["user_subject_id", "task_id"], name: "index_user_tasks_on_user_subject_id_and_task_id", unique: true
    t.index ["user_subject_id"], name: "index_user_tasks_on_user_subject_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.integer "gender"
    t.date "date_start"
    t.string "university"
    t.string "program"
    t.string "avatar"
    t.boolean "suppervisor"
    t.string "password_digest"
    t.string "reset_digest"
    t.datetime "reset_send_at"
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "course_subjects", "courses"
  add_foreign_key "course_subjects", "subjects"
  add_foreign_key "tasks", "subjects"
  add_foreign_key "user_courses", "courses"
  add_foreign_key "user_courses", "users"
  add_foreign_key "user_subjects", "course_subjects"
  add_foreign_key "user_subjects", "users"
  add_foreign_key "user_tasks", "tasks"
  add_foreign_key "user_tasks", "user_subjects"
end
