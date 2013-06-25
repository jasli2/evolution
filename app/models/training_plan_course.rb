# == Schema Information
#
# Table name: training_plan_courses
#
#  id               :integer          not null, primary key
#  training_plan_id :integer
#  course_id        :integer
#  course_type      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class TrainingPlanCourse < ActiveRecord::Base
  attr_accessible :course_id, :training_plan_id, :course_type_str

  validates :course_id, :presence => true
  validates :training_plan_id, :presence => true

  belongs_to :training_plan
  belongs_to :course

  # mapping course type
  COURSE_TYPE = [:required, :optional, :rejected]
  
  def course_type_str
    COURSE_TYPE[self.course_type] if self.course_type
  end

  def course_type_str=(c_type)
    if COURSE_TYPE.index(c_type.to_sym)
      self.course_type = COURSE_TYPE.index(c_type.to_sym) 
    else
      self.course_type = nil
    end
  end
  validates :course_type_str, :inclusion => { :in => [:required, :optional, :rejected], :message => "%{value} is not a valid course type" }

end
