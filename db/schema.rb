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

ActiveRecord::Schema.define(version: 20180502170618) do

  create_table "contract_faculty_links", force: :cascade do |t|
    t.integer "contract_id"
    t.integer "faculty_id"
    t.string "role"
    t.integer "pct_credit"
    t.index ["contract_id"], name: "index_contract_faculty_links_on_contract_id"
    t.index ["faculty_id"], name: "index_contract_faculty_links_on_faculty_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "osp_key"
    t.string "title"
    t.integer "sponsor_id"
    t.string "status"
    t.date "submitted"
    t.date "awarded"
    t.integer "requested"
    t.integer "funded"
    t.integer "total_anticipated"
    t.date "start_date"
    t.date "end_date"
    t.string "grant_contract"
    t.string "base_agreement"
    t.index ["osp_key"], name: "index_contracts_on_osp_key", unique: true
    t.index ["sponsor_id"], name: "index_contracts_on_sponsor_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "academic_course_id"
    t.string "term"
    t.integer "calendar_year"
    t.string "course_short_description"
    t.text "course_long_description"
    t.index ["academic_course_id"], name: "index_courses_on_academic_course_id", unique: true
  end

  create_table "faculties", force: :cascade do |t|
    t.string "access_id"
    t.string "f_name"
    t.string "l_name"
    t.string "m_name"
    t.index ["access_id"], name: "index_faculties_on_access_id", unique: true
  end

  create_table "sections", force: :cascade do |t|
    t.integer "course_id"
    t.integer "faculty_id"
    t.string "class_campus_code"
    t.string "cross_listed_flag"
    t.integer "course_number"
    t.string "course_suffix"
    t.string "subject_code"
    t.string "class_section_code"
    t.string "course_credits"
    t.integer "current_enrollment"
    t.integer "instructor_load_factor"
    t.string "instruction_mode"
    t.string "course_component"
    t.string "xcourse_course_pre"
    t.integer "xcourse_course_num"
    t.string "xcourse_course_suf"
    t.index ["course_id"], name: "index_sections_on_course_id"
    t.index ["faculty_id"], name: "index_sections_on_faculty_id"
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "sponsor_name"
    t.string "sponsor_type"
    t.index ["sponsor_name"], name: "index_sponsors_on_sponsor_name", unique: true
  end

end
