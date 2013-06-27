# == Schema Information
#
# Table name: training_plans
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  feedback_deadline   :date
#  end_day             :date
#  required_course_min :integer          default(0)
#  required_course_max :integer          default(0)
#  optional_course_min :integer          default(0)
#  optional_course_max :integer          default(0)
#  status              :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class TrainingPlan < ActiveRecord::Base
  attr_accessible :title, :feedback_deadline, :end_day, :status
  attr_accessible :required_course_min, :required_course_max, :optional_course_min, :optional_course_max

  validates :title, :presence => true
  validates :feedback_deadline, :presence => true

  has_many :training_plan_users
  has_many :users, :through => :training_plan_users

  has_many :training_plan_courses
  has_many :courses, :through => :training_plan_courses
  has_many :training_plan_required_courses, :class_name => 'TrainingPlanCourse', :conditions => { :course_type => TrainingPlanCourse::COURSE_TYPE.index(:required) }
  has_many :required_courses, :through => :training_plan_required_courses, :source => :course
  has_many :training_plan_optional_courses, :class_name => 'TrainingPlanCourse', :conditions => { :course_type => TrainingPlanCourse::COURSE_TYPE.index(:optional) }
  has_many :optional_courses, :through => :training_plan_optional_courses, :source => :course

  has_many :training_plan_feedbacks
  has_many :feedbacks, :through => :training_plan_feedbacks

  has_many :feedback_todos, :class_name => 'Todo', :as => :source, :conditions => { :todo_type => 'feedback' }

  after_create :gen_feedback_todos

  private
    def gen_feedback_todos  # TODO :: move it into background task
      users.each do |u|
        u.todos.create!(:source => self, :todo_type => 'feedback', :deadline => self.feedback_deadline)
      end
    end
end
