# == Schema Information
#
# Table name: examinations
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  creator_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deadline     :datetime
#  state        :string(255)
#  finished_at  :datetime
#  cancelled_at :datetime
#  published_at :datetime
#

class Examination < ActiveRecord::Base
  attr_accessible :creator_id, :title
  attr_accessible :deadline

  validates :creator_id, :presence => true
  validates :title, :presence => true
  validates :deadline, :presence => true

  has_many :examination_users
  has_many :users, :through => :examination_users
  attr_accessible :user_ids

  
  has_many :feedbacks, :class_name => 'ExaminationFeedback'
  has_many :feedback_todos, :class_name => 'Todo', :as => :source, :conditions => {:todo_type => 'feedback'}
  has_many :notifications, :class_name => 'Notification', :as => :source

  has_many :examination_questions
  has_many :questions, :through => :examination_questions
  has_many :papers
  belongs_to :creator, :class_name => "User"

  after_create :determine_first_state, :gen_feedback_todos



  #state machine
  state_machine :state, :initial => :created  do

    after_transition :on => :all_feedbacked do |exam, transition|
      exam.notifications.create!(:user_id => tp.creator.id, :notification_type => "finished") if exam.creator
      exam.finished_at = Time.zone.now
    end

    after_transition :on => :cancel do |tp, transition|
      tp.cancelled_at = Time.zone.now
    end

    after_transition :on => :publish do |exam, transition|
      #gen_feedback_todos
      exam.users.each do |user|
        todo =  exam.user_todo_exam(user, exam)
        todo.update_attribute(:todo_type, 'published')
        exam.notifications.create!(:user_id => user.id, :notification_type => "published") if user
      end

    end

    event :all_feedbacked do
      transition :published => :finished
    end

    event :feedback_timeout do
      transition :published => :finished
    end

    event :cancel do
      transition any => :cancelled
    end

    event :publish do
      transition :pending_publish => :published
    end  
  end

  def user_todo_exam(ur, exam)
    ur.todos.where(:source_type => "Examination", :source_id => exam.id).first
  end

  def feedback_created(feedback)
    if feedbacks.count == users.count
      self.all_feedbacked
    end
  end

  def confirm_publish
    self.publish
  end

  private
    def determine_first_state
      self.state = "pending_publish"
      self.save!
    end

    def gen_feedback_todos
      users.each do |u|
        u.todos.create!(:source => self, :todo_type => 'examination_pending', :deadline => self.deadline)
      end
    end

end
