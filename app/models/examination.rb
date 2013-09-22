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
  attr_accessible :deadline, :published_at
  attr_accessible :course_class_id

  validates :creator_id, :presence => true
  validates :title, :presence => true
  validates :deadline, :presence => true

  has_many :examination_users
  has_many :users, :through => :examination_users
  attr_accessible :user_ids

  
  has_many :feedbacks, :class_name => 'ExaminationFeedback'
  has_many :feedback_todos, :class_name => 'Todo', :as => :source, :conditions => {:todo_type => 'published'}
  has_many :notifications, :class_name => 'Notification', :as => :source

  has_many :examination_questions
  has_many :questions, :through => :examination_questions
  has_many :papers, :dependent => :destroy
  belongs_to :creator, :class_name => "User"
  belongs_to :course_class

  after_create :determine_first_state

  #state machine
  state_machine :state, :initial => :created  do

    after_transition :on => :all_feedbacked do |exam, transition|
      exam.finished_at = Time.zone.now
      exam.save
      exam.creator.todos.create!(:source => exam, :todo_type => 'pending_finish', :deadline =>exam.set_day(exam.deadline, 3.day)) if exam.creator
    end

    after_transition :on => :cancel do |exam, transition|
      exam.cancelled_at = Time.zone.now
      exam.save
    end

    after_transition :on => :feedback_timeout do |exam, transition|
      exam.finished_at = exam.deadline
      exam.save
      creator.todos.create!(:source => exam, :todo_type => 'pending_finish', :deadline =>exam.set_day(self.deadline, 3.day)) if exam.creator
    end

    after_transition :on => :publish do |exam, transition|
      #gen_feedback_todos
      exam.users.each do |user|
        #todo =  exam.user_todo_exam(user)
        user.todos.create!(:source => exam, :todo_type => 'published', :deadline => exam.deadline)
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

  def find_user_todo(current_user_id)
    self.feedback_todos.find_by_user_id(current_user_id)
  end

  def check_user_paper(current_user_id)
    paper =  self.papers.find_by_user_id(current_user_id)
    if paper.nil?
      paper = self.papers.create!(:user_id => current_user_id)
      self.exam_question_answere(paper.id)
    end
    return paper
  end

  def get_choice_question
    self.questions.where(:question_type => Question::QUESTION_TYPE.index(:choice))
  end

  def get_judgement_question
    self.questions.where(:question_type => Question::QUESTION_TYPE.index(:judgement))
  end

  def get_dialogical_question
    self.questions.where(:question_type => Question::QUESTION_TYPE.index(:dialogical))
  end

  def user_todo_exam(ur)
    ur.todos.where(:source_type => "Examination", :source_id => self.id).first if ur
  end

  def feedback_created(feedback)
    if self.feedbacks.count == self.users.count
      self.all_feedbacked
    end
  end

  def confirm_publish
    self.publish
  end

  def exam_question_answere(paper_id)
    self.questions.all.each do |question|
       question.user_answers.create!(:paper_id => paper_id)
    end
  end

  def answer_kind_num(type, qid)
    UserAnswer.get_user_answer(type).where(:question_id => qid)
  end

  def answer_all_num(qid)
    UserAnswer.get_all_answer(qid)
  end

  def set_day(old, increment)
    return old + increment
  end

  #function : 
  #1、correct student paper 
  #2、create todo for examination creator to finish paper
  #TODO:paper processing should more perfect
  def finish_paper(paper_id, feedback_id, answers)
    answers.each do |key, value|
      puts key.split('_')[0]
      puts key.split('_')[1]
      q_type = key.split('_')[0]
      q_id = key.split('_')[1].to_i
      sub = Question.find(q_id)
      sub_ans = sub.user_answers.where(:paper_id => paper_id).first
      unless q_type.eql?("dialogical")
        if value.nil?
          state = false
        else
          state = sub.answer.upcase.eql?(value.upcase)
        end
      end
      sub_ans.update_attributes(:content => value, :correct => state)
    end
    #to tell creator  about student  submit a paper and crorrect paper
    #teacher should correct paper after examination  3 day
    paper = Paper.find(paper_id)
    paper.update_attributes(:examination_feedback_id => feedback_id)
    #creator.todos.create!(:source => paper, :todo_type => 'pending_finish', :deadline =>set_day(self.deadline, 3.day)) if creator
  end

  private
    def determine_first_state
      self.state = "pending_publish"
      self.save!
    end

    def gen_feedback_notification
      users.each do |u|
        self.notifications.create!(:user_id => u.id, :notification_type => 'examination_pending') if u
      end
    end

end
