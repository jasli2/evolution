# encoding: utf-8
module UsersHelper
  def user_avatar_path(u, type)
    u.avatar_url(type) || "defaut_user_avatar_#{type}.png"
  end

  def user_level(u)
    "Lv" + ( 2 + u.teacher_rate.to_i ).to_s
  end

  def todo_description(todo)
    if todo.source.nil?
      return "未知错误"
    end

    case todo.source_type
    when 'TrainingPlan'
      if todo.todo_type == 'feedback'
        "培训计划：" + todo.source.title + " 需要提供培训反馈。" + "  结束日期：#{todo.source.feedback_deadline.to_date}"
      end
    when 'Examination'
      if todo.todo_type == 'published'
        "请及时参加考试：" + todo.source.title + "  结束日期：#{todo.source.deadline.to_date}"
      elsif todo.todo_type == 'examination_pending'
        "考试管理：" + todo.source.title + "即将发布"
      end
    when 'Paper'
      if todo.todo_type == 'pending_finish'
        todo.source.user.name + " 已经完成\"" + todo.source.examination.title + "\"考试"
      end
    else
      # unknow todo
      "unknown todo!"
    end
  end

  def todo_url(todo)
    if todo.source.nil?
      return "#myMode"
    end
    case todo.source_type
    when 'TrainingPlan'
      if todo.todo_type == 'feedback'
        new_training_plan_feedback_path(todo.source)
      end
    when 'Examination'
      if todo.todo_type == 'feedback'
        "#MyResult"
      elsif todo.todo_type == 'examination_pending'
        examinations_path()
      elsif todo.todo_type == 'published'
        new_examination_exam_feedback_path(todo.source)
        # examinations_path()
      end
    when 'Paper'
      if todo.todo_type == 'pending_finish'
        exam_id = todo.source.examination.id
        feedback_id = todo.source.examination_feedback.id
        examination_exam_feedback_path(:examination_id => exam_id, :id => feedback_id)
      end
    else
      # unknow action TODO
      ""
    end
  end

  def notice_description(n)
    if n.source.nil?
      return "未知错误"
    end

    case n.source_type
    when 'TrainingPlan'
      if n.notification_type == 'all_feedback'
        "培训计划：" + n.source.title + " 所有培训学员都已经提交反馈。"
      elsif n.notification_type == 'published'
        "培训计划：" + n.source.title + " 已经发布。"
      end
    when 'Examination'
      if n.notification_type == 'all_feedback'
        "考试管理：" + n.source.title + " 所有考生已提交试卷"
      elsif n.notification_type == 'published'
        "考试管理：" + n.source.title + "  已发布，结束日期: #{n.source.deadline.to_date}"
      elsif n.notification_type == 'finished'
        "考试管理：" + n.source.title + " 已经结束"
      else
        "考试管理：未知状态"
      end
    when 'CourseClass'
      if n.notification_type == 'assign_teacher'
        "你已经被委任为课程：" +  n.source.course.title + "的班级老师。" 
      elsif n.notification_type == 'assign_assistent'
        "你已经被委任为课程：" +  n.source.course.title + "的班级助教。"
      elsif 'publish_time_address'
        "班级：" + n.source.course.title + "（班级ID-" + n.source.id.to_s + "）" + "已经发布了上课时间和地点。"
      else
        "班级通知类型未知：" + n.notification_type
      end
    else
      "unknow notification"
    end
  end

  def notice_url(n)
    case n.source_type
    when 'TrainingPlan'
      training_plan_path(n.source)
    when 'Examination'
      if n.source.state == "finished"
        result_examination_path(n.source)
      else
        "#myMode"
      end
    when 'CourseClass'
      class_path(n.source)
    else
      ""
    end    
  end
end
