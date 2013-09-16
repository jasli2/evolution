# encoding: utf-8
# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  source_type       :string(255)
#  source_id         :integer
#  notification_type :string(255)
#  viewed_at         :datetime
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Notification < ActiveRecord::Base
  attr_accessible :notification_type, :source_id, :source_type, :viewed_at, :user_id

  validates :user_id, :presence => true
  validates :notification_type, :presence => true

  belongs_to :user
  belongs_to :source, :polymorphic => true  
  attr_accessible :source

  scope :active, where(:viewed_at => nil)

  def set_viewed
    update_attributes(:viewed_at => Time.zone.now)
  end

  def _description
    if source.nil?
      return "未知错误"
    end

    case source_type
    when 'TrainingPlan'
      if notification_type == 'all_feedback'
        "培训计划：" + source.title + " 所有培训学员都已经提交反馈。"
      elsif notification_type == 'published'
        "培训计划：" + source.title + " 已经发布。"
      end
    when 'Examination'
      if notification_type == 'all_feedback'
        "考试管理：" + source.title + " 所有考生已提交试卷"
      elsif notification_type == 'published'
        "考试管理：" + source.title + "  已发布，结束日期: #{n.source.deadline.to_date}"
      elsif notification_type == 'finished'
        "考试管理：" + source.title + " 已经结束"
      else
        "考试管理：未知状态"
      end
    when 'CourseClass'
      if notification_type == 'assign_teacher'
        "你已经被委任为课程：" +  source.course.title + "的班级老师。" 
      elsif notification_type == 'assign_assistent'
        "你已经被委任为课程：" +  source.course.title + "的班级助教。"
      elsif 'publish_time_address'
        "班级：" + source.course.title + "（班级ID-" + source.id.to_s + "）" + "已经发布了上课时间和地点。"
      else
        "班级通知类型未知：" + notification_type
      end
    else
      "unknow notification"
    end
  end

  def _url
    case source_type
    when 'TrainingPlan'
      training_plan_path(source)
    when 'Examination'
      if n.source.state == "finished"
        result_examination_path(source)
      else
        "#myMode"
      end
    when 'CourseClass'
      class_path(source)
    else
      ""
    end    
  end

end
