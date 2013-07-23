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
#  state               :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  finished_at         :datetime
#  cancelled_at        :datetime
#  creator_id          :integer
#

class TrainingPlan < ActiveRecord::Base
  attr_accessible :title, :feedback_deadline, :end_day, :creator_id
  attr_accessible :required_course_min, :required_course_max, :optional_course_min, :optional_course_max

  validates :title, :presence => true, :uniqueness => true
  validates :feedback_deadline, :presence => true

  belongs_to :creator, :class_name => 'User'
  has_many :training_plan_users
  has_many :users, :through => :training_plan_users
  attr_accessible :user_ids

  has_many :training_plan_courses
  has_many :courses, :through => :training_plan_courses
  has_many :training_plan_required_courses, :class_name => 'TrainingPlanCourse', :conditions => { :course_type => TrainingPlanCourse::COURSE_TYPE.index(:required) }
  has_many :required_courses, :through => :training_plan_required_courses, :source => :course
  has_many :training_plan_optional_courses, :class_name => 'TrainingPlanCourse', :conditions => { :course_type => TrainingPlanCourse::COURSE_TYPE.index(:optional) }
  has_many :optional_courses, :through => :training_plan_optional_courses, :source => :course
  has_many :training_plan_rejected_courses, :class_name => 'TrainingPlanCourse', :conditions => { :course_type => TrainingPlanCourse::COURSE_TYPE.index(:rejected) }
  has_many :rejected_courses, :through => :training_plan_rejected_courses, :source => :course
  attr_accessible :course_ids, :required_course_ids, :optional_course_ids

  #has_many :training_plan_feedbacks
  has_many :feedbacks, :class_name => 'TrainingPlanFeedback'

  has_many :feedback_todos, :class_name => 'Todo', :as => :source, :conditions => { :todo_type => 'feedback' }
  has_many :notifications, :class_name => 'Notification', :as => :source

  # user training progress
  has_many :user_progresses, :class_name => 'UserClassProgress'

  # return courses which belongs to user
  # TODO: need revisite if add training plan type
  def course_for_user(u)
    if u and users.include?(u) and feedbacks.find_by_user_id(u.id)
      courses.find feedbacks.find_by_user_id(u.id).course_ids
    end
  end

  after_create :determine_first_state, :gen_feedback_todos

  # state machine
  state_machine :state, :initial => :created do
    after_transition :on => :finish do |tp, transition|
      tp.finished_at = Time.zone.now
    end

    after_transition :on => :cancel do |tp, transition|
      tp.cancelled_at = Time.zone.now
    end

    after_transition :on => :all_feedbacked do |tp, transition|
      tp.notifications.create!(:user_id => tp.creator.id, :notification_type => "all_feedback") if tp.creator
    end

    after_transition :on => :feedback_timeout do |tp, transition|
      tp.notifications.create!(:user_id => tp.creator.id, :notification_type => "feedback_timeout") if tp.creator
    end

    after_transition :on => :publish do |tp, transition|
      # need to move to background task. TODO
      tp.users.each do |user|
        tp.notifications.create!(:user_id => user.id, :notification_type => "published") if user
      end
    end

    event :all_feedbacked do
      transition :pending_feedback => :pending_publish
    end

    event :feedback_timeout do
      transition :pending_feedback => :pending_publish
    end

    event :publish do
      transition :pending_publish => :started
    end

    event :finish do
      transition :started => :finished
    end

    event :cancel do 
      transition any => :cancelled
    end
  end

  scope :active, where(:state => [:created, :pending_feedback, :pending_publish, :started])

  def feedback_created(feedback)
    if feedbacks.count == users.count
      self.all_feedbacked
    end
  end

  def confirm_publish(params)
    # TODO :: currently this function will delete data then create data again.
    # Need to revisit it.
    course_backup = course_ids

    if update_attributes(params)
      course_backup -= required_course_ids
      course_backup -= optional_course_ids

      rejected_course_ids = course_backup

      self.publish
    else
      false
    end
  end

  def required?(course)
    required_course_ids.include? course.id
  end

  private
    def determine_first_state
      # here to determine different state based on training type TODO
      self.state = 'pending_feedback'
      self.save!
    end

    def gen_feedback_todos  # TODO :: move it into background task
      users.each do |u|
        u.todos.create!(:source => self, :todo_type => 'feedback', :deadline => self.feedback_deadline)
      end
    end
end
