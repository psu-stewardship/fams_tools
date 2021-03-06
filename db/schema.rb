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

ActiveRecord::Schema.define(version: 2018050314201234) do

  create_table "authors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "f_name"
    t.string "m_name"
    t.string "l_name"
    t.bigint "work_id"
    t.index ["work_id"], name: "fk_rails_ef7807179c"
  end

  create_table "contract_faculty_links", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "role"
    t.integer "pct_credit"
    t.bigint "contract_id"
    t.bigint "faculty_id"
    t.index ["contract_id", "faculty_id"], name: "index_contract_faculty_links_on_contract_id_and_faculty_id", unique: true
    t.index ["faculty_id"], name: "fk_rails_7f7c136a9d"
  end

  create_table "contracts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "osp_key"
    t.string "title"
    t.bigint "sponsor_id"
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
    t.date "notfunded"
    t.float "effort_academic"
    t.float "effort_summer"
    t.float "effort_calendar"
    t.index ["osp_key"], name: "index_contracts_on_osp_key", unique: true
    t.index ["sponsor_id"], name: "fk_rails_918599a14c"
  end

  create_table "courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "academic_course_id"
    t.string "term"
    t.integer "calendar_year"
    t.string "course_short_description"
    t.text "course_long_description"
    t.index ["academic_course_id", "term", "calendar_year"], name: "index_courses_on_academic_course_id_and_term_and_calendar_year", unique: true
  end

  create_table "editors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "f_name"
    t.string "m_name"
    t.string "l_name"
    t.bigint "work_id"
    t.index ["work_id"], name: "fk_rails_6c877ed7df"
  end

  create_table "external_authors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "publication_id"
    t.string "f_name"
    t.string "m_name"
    t.string "l_name"
    t.string "role"
    t.string "extOrg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "fk_rails_eb03e1acd5"
  end

  create_table "faculties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "access_id"
    t.bigint "user_id"
    t.string "f_name"
    t.string "l_name"
    t.string "m_name"
    t.string "college"
    t.string "campus"
    t.index ["access_id"], name: "index_faculties_on_access_id", unique: true
  end

  create_table "gpas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "faculty_id"
    t.string "semester"
    t.integer "year"
    t.string "course_prefix"
    t.string "course_number"
    t.string "course_number_suffix"
    t.string "section_number"
    t.string "campus"
    t.integer "number_of_grades"
    t.float "course_gpa"
    t.integer "grade_dist_a"
    t.integer "grade_dist_a_minus"
    t.integer "grade_dist_b_plus"
    t.integer "grade_dist_b"
    t.integer "grade_dist_b_minus"
    t.integer "grade_dist_c_plus"
    t.integer "grade_dist_c"
    t.integer "grade_dist_d"
    t.integer "grade_dist_f"
    t.integer "grade_dist_w"
    t.integer "grade_dist_ld"
    t.integer "grade_dist_other"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id", "semester", "year", "course_prefix", "course_number", "course_number_suffix", "section_number", "campus"], name: "unique_key", unique: true, length: { semester: 50, course_prefix: 50, course_number_suffix: 50, campus: 50 }
    t.index ["faculty_id"], name: "index_gpas_on_faculty_id"
  end

  create_table "integrations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "process_type"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personal_contacts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "faculty_id", null: false
    t.string "telephone_number"
    t.string "postal_address"
    t.string "department"
    t.string "title"
    t.text "ps_research"
    t.text "ps_teaching"
    t.string "ps_office_address"
    t.string "facsimile_telephone_number"
    t.string "cn"
    t.string "mail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid", null: false
    t.string "personal_web"
    t.index ["faculty_id"], name: "index_personal_contacts_on_faculty_id", unique: true
  end

  create_table "presentation_contributors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "presentation_id", null: false
    t.string "f_name"
    t.string "m_name"
    t.string "l_name"
    t.index ["presentation_id"], name: "index_presentation_contributors_on_presentation_id"
  end

  create_table "presentations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "faculty_id", null: false
    t.string "title"
    t.string "dty_date"
    t.string "name"
    t.string "org"
    t.string "location"
    t.index ["faculty_id"], name: "index_presentations_on_faculty_id"
  end

  create_table "publication_faculty_links", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "faculty_id"
    t.bigint "publication_id"
    t.string "category"
    t.string "dtm"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "fk_rails_6b4e572ec8"
    t.index ["publication_id"], name: "fk_rails_7abcf28acb"
  end

  create_table "publication_listings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "pure_id"
    t.text "title"
    t.integer "volume"
    t.integer "dty"
    t.integer "dtd"
    t.string "journal_title"
    t.string "journal_issn"
    t.integer "issue"
    t.string "journal_uuid"
    t.string "page_range"
    t.integer "articleNumber"
    t.string "publisher"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "edition"
    t.text "abstract"
    t.text "secondary_title"
    t.integer "citation_count"
    t.boolean "authors_et_al"
    t.string "ai_ids"
    t.string "pure_ids"
    t.string "web_address"
    t.text "editors"
    t.string "institution"
    t.string "isbnissn"
    t.string "pubctyst"
    t.index ["pure_ids", "ai_ids"], name: "index_publications_on_pure_ids_and_ai_ids", unique: true
  end

  create_table "sections", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "class_campus_code"
    t.string "cross_listed_flag"
    t.string "course_number"
    t.string "course_suffix"
    t.string "subject_code"
    t.string "class_section_code"
    t.string "course_credits"
    t.integer "current_enrollment"
    t.integer "instructor_load_factor"
    t.string "instruction_mode"
    t.string "instructor_role"
    t.string "course_component"
    t.string "xcourse_course_pre"
    t.integer "xcourse_course_num"
    t.string "xcourse_course_suf"
    t.bigint "course_id"
    t.bigint "faculty_id"
    t.index ["course_id"], name: "fk_rails_20b1e5de46"
    t.index ["faculty_id", "course_id", "class_campus_code", "subject_code", "course_number", "course_suffix", "class_section_code", "course_component"], name: "pkey", unique: true, length: { class_campus_code: 50, subject_code: 50, course_suffix: 50, class_section_code: 50, course_component: 50 }
  end

  create_table "sponsors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "sponsor_name"
    t.string "sponsor_type"
    t.index ["sponsor_name"], name: "index_sponsors_on_sponsor_name", unique: true
  end

  create_table "works", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "publication_listing_id"
    t.text "title"
    t.string "journal"
    t.string "volume"
    t.string "edition"
    t.string "pages"
    t.string "item"
    t.string "booktitle"
    t.string "container"
    t.string "contype"
    t.string "genre"
    t.string "doi"
    t.string "institution"
    t.string "isbn"
    t.string "location"
    t.string "note"
    t.string "publisher"
    t.string "retrieved"
    t.string "tech"
    t.string "translator"
    t.string "unknown"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "date"
    t.text "citation"
    t.index ["publication_listing_id"], name: "index_works_on_publication_listing_id"
  end

  add_foreign_key "authors", "works", on_delete: :cascade
  add_foreign_key "contract_faculty_links", "contracts"
  add_foreign_key "contract_faculty_links", "faculties"
  add_foreign_key "contracts", "sponsors"
  add_foreign_key "editors", "works", on_delete: :cascade
  add_foreign_key "external_authors", "publications"
  add_foreign_key "gpas", "faculties"
  add_foreign_key "personal_contacts", "faculties"
  add_foreign_key "presentation_contributors", "presentations", on_delete: :cascade
  add_foreign_key "presentations", "faculties", on_delete: :cascade
  add_foreign_key "publication_faculty_links", "faculties"
  add_foreign_key "publication_faculty_links", "publications"
  add_foreign_key "sections", "courses"
  add_foreign_key "sections", "faculties"
  add_foreign_key "works", "publication_listings", on_delete: :cascade
end
