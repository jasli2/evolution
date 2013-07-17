# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130716100205) do

  create_table "action_permissions", :force => true do |t|
    t.integer  "model_permission_id"
    t.string   "action_name"
    t.integer  "user_scope"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "activities", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "activity_has_courses", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "course_id"
    t.integer  "activity_id"
  end

  create_table "activity_has_users", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "activity_id"
    t.integer  "user_id"
  end

  create_table "attachments", :force => true do |t|
    t.string   "description"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "file"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "class_user_roles", :force => true do |t|
    t.integer  "course_class_id"
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "repcomment_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["updated_at"], :name => "index_comments_on_updated_at"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "competencies", :force => true do |t|
    t.string   "name",        :limit => 40
    t.string   "description"
    t.integer  "category_id", :limit => 2
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "competency_level_has_courses", :force => true do |t|
    t.integer  "competency_level_id"
    t.integer  "course_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "competency_level_requirements", :force => true do |t|
    t.string   "description"
    t.integer  "competency_level_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "weight"
  end

  create_table "competency_levels", :force => true do |t|
    t.integer  "level",         :limit => 1
    t.string   "description"
    t.integer  "competency_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "competency_users", :force => true do |t|
    t.integer  "self_eval_level"
    t.integer  "mgr_eval_level"
    t.integer  "user_id"
    t.integer  "competency_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "course_classes", :force => true do |t|
    t.integer  "course_id"
    t.string   "state"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "creator_id"
    t.datetime "teach_date"
    t.datetime "eroll_deadline"
  end

  create_table "courses", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "creator_id"
    t.integer  "duration"
    t.string   "course_type"
    t.integer  "teacher_id"
    t.text     "description"
    t.string   "cover_image"
    t.string   "audience"
    t.string   "target"
    t.string   "teach_type"
    t.string   "source_type"
    t.string   "lesson"
  end

  create_table "discusses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_class_id"
    t.string   "title"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "examination_feedbacks", :force => true do |t|
    t.integer  "examination_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "examination_questions", :force => true do |t|
    t.integer  "examination_id"
    t.integer  "question_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "examination_users", :force => true do |t|
    t.integer  "examination_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "examinations", :force => true do |t|
    t.string   "title"
    t.integer  "creator_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "deadline"
    t.string   "state"
    t.datetime "finished_at"
    t.datetime "cancelled_at"
    t.datetime "published_at"
  end

  create_table "feed_items", :force => true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "feed_items", ["item_id", "item_type"], :name => "index_feed_items_on_item_id_and_item_type"

  create_table "feeds", :force => true do |t|
    t.integer  "user_id"
    t.integer  "feed_item_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "feeds", ["user_id", "feed_item_id"], :name => "index_feeds_on_user_id_and_feed_item_id"

  create_table "model_permissions", :force => true do |t|
    t.integer  "user_id"
    t.string   "model_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "notification_type"
    t.datetime "viewed_at"
    t.integer  "user_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "papers", :force => true do |t|
    t.integer  "score"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "user_id"
    t.integer  "examination_id"
  end

  create_table "position_competency_levels", :force => true do |t|
    t.integer  "standard"
    t.integer  "position_id"
    t.integer  "competency_level_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "position_has_courses", :force => true do |t|
    t.integer  "position_id"
    t.integer  "course_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "positions", :force => true do |t|
    t.string   "name",        :limit => 40
    t.string   "description"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "standard"
  end

  create_table "questions", :force => true do |t|
    t.text     "qdata"
    t.string   "answer"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "correct"
    t.integer  "question_type"
  end

  create_table "todos", :force => true do |t|
    t.string   "source_type"
    t.integer  "source_id"
    t.datetime "finish_at"
    t.datetime "deadline"
    t.string   "todo_type"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topics", ["updated_at"], :name => "index_topics_on_updated_at"
  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "training_feedback_courses", :force => true do |t|
    t.integer  "training_plan_feedback_id"
    t.integer  "course_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "training_plan_courses", :force => true do |t|
    t.integer  "training_plan_id"
    t.integer  "course_id"
    t.integer  "course_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "training_plan_feedbacks", :force => true do |t|
    t.integer  "training_plan_id"
    t.integer  "user_id"
    t.string   "note"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "training_plan_users", :force => true do |t|
    t.integer  "training_plan_id"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "training_plans", :force => true do |t|
    t.string   "title"
    t.date     "feedback_deadline"
    t.date     "end_day"
    t.integer  "required_course_min", :default => 0
    t.integer  "required_course_max", :default => 0
    t.integer  "optional_course_min", :default => 0
    t.integer  "optional_course_max", :default => 0
    t.string   "state"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.datetime "finished_at"
    t.datetime "cancelled_at"
    t.integer  "creator_id"
  end

  create_table "user_answers", :force => true do |t|
    t.string   "content"
    t.boolean  "correct"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "question_id"
    t.integer  "paper_id"
  end

  create_table "user_class_progresses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_class_id"
    t.integer  "training_plan_id"
    t.string   "progress"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "user_course_progresses", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.string   "course_progress"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "user_relations", :force => true do |t|
    t.integer  "leader_id"
    t.integer  "follower_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_relations", ["follower_id"], :name => "index_user_relations_on_follower_id"
  add_index "user_relations", ["leader_id", "follower_id"], :name => "index_user_relations_on_leader_id_and_follower_id", :unique => true
  add_index "user_relations", ["leader_id"], :name => "index_user_relations_on_leader_id"

  create_table "users", :force => true do |t|
    t.string   "email",            :limit => 128,                    :null => false
    t.integer  "manager_id"
    t.date     "birthday"
    t.date     "joined_at"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.integer  "position_id"
    t.string   "password_digest"
    t.string   "name"
    t.boolean  "is_admin",                        :default => false
    t.string   "avatar"
    t.integer  "staff_id"
    t.integer  "phone_num"
    t.integer  "mobile_phone"
    t.string   "department"
    t.integer  "department_level"
    t.string   "self_intro"
    t.integer  "teacher_rate"
    t.boolean  "is_assessed",                     :default => false
  end

end
