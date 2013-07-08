# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(128)      not null
#  manager_id       :integer
#  birthday         :date
#  joined_at        :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  position_id      :integer
#  password_digest  :string(255)
#  name             :string(255)
#  is_admin         :boolean          default(FALSE)
#  avatar           :string(255)
#  staff_id         :integer
#  phone_num        :integer
#  mobile_phone     :integer
#  department       :string(255)
#  department_level :integer
#  self_intro       :string(255)
#  teacher_rate     :integer
#  is_assessed      :boolean          default(FALSE)
#

require 'file_size_validator'

class User < ActiveRecord::Base
  paginates_per 15

  attr_accessible :name, :email, :password, :password_confirmation, :position_id, :avatar, :self_intro, :teacher_rate
  attr_accessible :manager_id,:birthday, :joined_at, :phone_num, :mobile_phone, :staff_id
  attr_accessible :department, :department_level,

  has_secure_password

  validates :name, :presence => true
  validates :password, :presence => true, :length => { minimum: 6}, :on => :create
  validates :password_confirmation, :presence => true, :on => :create
  validates :email,
    :presence => true,
    :uniqueness => {case_sensitive: false},
    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Not a valid email address!" }

  before_save { |user| user.email = email.downcase}

  has_many :subordinates, :class_name => "User", :foreign_key => "manager_id"
  belongs_to :manager, :class_name => "User"

  belongs_to :position
  attr_accessible :position

  has_many :create_courses, :foreign_key => "creator_id", :class_name => 'Course'
  has_many :teach_courses, :foreign_key => "teacher_id", :class_name => 'Course'

  has_many :competency_users
  has_many :competencies, :through => :competency_users

  has_many :user_course_progresses
  has_many :course_progresses, :through => :user_course_progresses

  has_many :examinations, :foreign_key => "creator_id"

  #relations - for followed
  has_many :user_relations, :foreign_key => 'follower_id', :dependent => :destroy
  has_many :followed_users, :through => :user_relations, :source => :leader
  # for fans
  has_many :reverse_user_relations, :class_name => 'UserRelation', :foreign_key => 'leader_id', :dependent => :destroy
  has_many :fans, :through => :reverse_user_relations, :source => :follower

  #feeds
  has_many :feeds
  has_many :feed_items, :through => :feeds, :order => 'id DESC'

  has_many :topics, :dependent => :destroy
  has_many :comments
  #has_many :reply_comments,  :foreign_key => 'reply_id', :class_name => 'Comment', :as => :commentable, :dependent => :destroy
  #validates :position_id, :presence => true

  # training plan
  has_many :created_training_plans, :class_name => 'TrainingPlan', :foreign_key => 'creator_id'
  has_many :training_plan_users
  has_many :tranning_plans, :through => :training_plan_users
  has_many :active_training_plans, :through => :training_plan_users, :source => :training_plan, :conditions => { :state => 'started' }
  has_many :training_plan_feedbacks
  has_many :training_feedbacks, :through => :training_plan_feedbacks

  # system notification
  has_many :notifications

  # course class
  has_many :as_admin_in_class, :class_name => 'ClassUserRole', :conditions => { :role => ['teacher', 'assistent'] }
  has_many :owned_classes, :through => :as_admin_in_class, :source => :course_class
  has_many :as_student_in_class, :class_name => 'ClassUserRole', :conditions => { :role => 'student' }
  has_many :joined_classes, :through => :as_student_in_class, :source => :course_class

  # user class progress
  has_many :class_progresses, :class_name => 'UserClassProgress'

  def erolled_class_for_course(c)
    class_progresses.find_by_course_class_id c.course_class_ids
  end
  
  # todos
  has_many :todos
  has_many :pending_todos, :class_name => 'Todo', :conditions => 'finish_at IS NULL'
  has_many :finished_todos, :class_name => 'Todo', :conditions => 'finish_at IS NOT NULL'

  # notifications
  has_many :notifications
  has_many :unread_notices, :class_name => 'Notification', :conditions => 'viewed_at IS NULL'

  scope :staff, where(:is_admin => false)
  scope :teacher, lambda { {:joins => :teach_courses, :group => "courses.teacher_id", :having => ["count(courses.teacher_id) > 0"]} }
  scope :assessed, where(:is_assessed => true)
  scope :assessing, where(:is_assessed => false)
  #def self.teacher_for_position(p)
  #  if p
  #    c = Course.for_position(p)
  #    cids = c.map {|c| c.id}
  #    includes(:teach_courses).where(:courses => {:id => cids})
  #  end
  #end

  # custom image sizes: each key is a version name
  IMAGE_CONFIG = {
    :crop => [1, 1],
    :large => [200, 200],
    :normal => [100, 100],
    :small => [50, 50]
  }
  mount_uploader :avatar, ImageUploader
  validates :avatar, :file_size => {:maximum => 1.megabytes.to_i }

  def latest_comments
    self.comments.order('create_at DESC').limit(10)
  end

  def latest_created_topics
    slef.topics.order('created_at DESC').limit(10)
  end
  #user relattionship
  def following?(other_user)
    user_relations.find_by_leader_id(other_user.id)
  end

  def follow!(other_user)
    user_relations.create!(leader_id: other_user.id)
  end

  def unfollow!(other_user)
    user_relations.find_by_leader_id(other_user.id).destroy
  end

  def admin?
    self.is_admin
  end

  def self.auth(email, password)
    user = User.find_by_email(email.downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  def self.to_csv(options = {})
    puts "***************************"
    puts "to csv is open"
    puts "****************************"
    header = ["name","Staff Id", "email", "Tel", "Mobile", "manager_name", "birthday", "position_name",  \
              "department", "department level", "Enroll Date", "teacher rate", "introduction", "following"]
    puts header

    CSV.generate(options) do |csv|
      csv << header
      all.each do |mUser|
        unless mUser.name == "admin"
          row_data = []
          row_data << mUser.name
          row_data << mUser.staff_id
          row_data << mUser.email
          row_data << mUser.phone_num
          row_data << mUser.mobile_phone
          if (!mUser.manager.nil?)
            row_data << mUser.manager.name
          else
            row_data << " "
          end
          #row_data << mUser.manager.manager_id
          if (mUser.birthday)
            row_data << mUser.birthday
          else
            row_data << " "
          end
          if (!mUser.position.nil?)
            row_data << mUser.position.name
          else
            row_data << " "
          end
          if (mUser.department)
            row_data << mUser.department
          else
            row_data << " "
          end

          if (mUser.department_level)
            row_data << mUser.department_level
          else
            row_data << " "
          end

          if (mUser.joined_at)
            row_data << mUser.joined_at
          else
            row_data << " "
          end

          if (mUser.teacher_rate)
            row_data << mUser.teacher_rate
          else
            row_data << " "
          end

          if (mUser.self_intro)
            row_data << mUser.self_intro
          else
            row_data << " "
          end
          followers = ""
          mUser.followed_users.all.each do |user|
            followers = followers + " " + user.name
          end
          if (!followers.empty?)
            row_data << followers
          else
            row_data << " "
          end
          csv << row_data
          end
      end

    end
  end

  def self.save!(obj, error_info = nil)
    begin
      obj.save!
    rescue
      if error_info != nil
        error_info["error_num"] = error_info["error_num"] + 1
      end 
    end
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    
    #for error info
    count = 0
    error_info = Hash.new
    error_name = Hash.new
    error_info["error_action"] = error_name
    error_info["error_num"] = count
    error_info["total"] = spreadsheet.last_row - 1

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header,spreadsheet.row(i)].transpose]
      name = row.first[0]
      #row = spreadsheet.row(i)
      user = find_by_email(row["email"]) || new

      unless (row["position_name"].nil? || row["position_name"].empty?)
        position = Position.find_by_name(row["position_name"])
        user.position_id = position.id
      end
      user.password = row["password"]
      user.password_confirmation = row["password"]
      user.name = row[name]
      user.email = row["email"]
      save!(user, error_info)
      if error_info["error_num"] != count
        count = error_info["error_num"]
        next
      end

      user.staff_id = row["Staff Id"]
      user.phone_num = row["Tel"]
      user.mobile_phone = row["Mobile"]
      unless (row["manager_name"].nil? || row["manager_name"].empty?)
        user.manager = User.find_by_name(row["manager_name"])
        user.manager_id = user.manager.staff_id
      end
      user.birthday = row["birthday"]
      user.department = row["department"]
      user.department_level = row["department level"]
      user.joined_at = row["Enroll Date"]
      user.teacher_rate=row["teacher rate"]
      user.self_intro=row["introduction"]
      save!(user, error_info)
      if error_info["error_num"] != count
        count = error_info["error_num"]
        next
      end
      unless (user.position_id.nil?)
        position.users << user
      end
    end
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header,spreadsheet.row(i)].transpose]
      name = row.first[0]
      user = find_by_email(row["email"])

      if ( user.nil?)
        puts "kong de "
        next
      end
      following = row["following"].split
      following.each do |name|
        follower = User.find_by_name(name)
        if follower.nil?
          next
        end
        unless (follower.nil?)
          unless user.following?(follower)
            user.follow!(follower)
          end 
        end
      end
    end

    return error_info
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
