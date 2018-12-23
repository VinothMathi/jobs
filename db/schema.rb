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

ActiveRecord::Schema.define(version: 2018_12_14_160636) do

  create_table "delayed_jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "schedule_id"
    t.integer "event_id"
    t.text "handler"
    t.integer "priority"
    t.integer "attempts", default: 0
    t.string "queue"
    t.datetime "run_at"
    t.string "status"
    t.string "locked_by"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.text "error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_delayed_jobs_on_schedule_id"
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code", "status"], name: "index_events_on_code_and_status"
  end

  create_table "events_schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "event_id"
    t.integer "schedule_id"
    t.index ["event_id", "schedule_id"], name: "index_events_schedules_on_event_id_and_schedule_id"
  end

  create_table "jobs_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "schedule_id"
    t.integer "event_id"
    t.text "handler"
    t.integer "priority"
    t.integer "attempts"
    t.string "queue"
    t.datetime "run_at"
    t.string "status"
    t.string "locked_by"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.text "error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_jobs_logs_on_schedule_id"
  end

  create_table "schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "priority"
    t.string "status"
    t.string "cron_schedule"
    t.string "queue"
    t.text "job"
    t.integer "user_id"
    t.integer "last_updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_schedules_on_status"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "login_identifier"
    t.string "name"
    t.string "email"
    t.string "status"
    t.string "roles"
    t.string "crypted_password"
    t.string "password_salt"
    t.string "persistence_token"
    t.string "perishable_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
