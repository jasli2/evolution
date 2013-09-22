# encoding: utf-8
module UsersHelper
  def user_avatar_path(u, type)
    u.avatar_url(type) || "defaut_user_avatar_#{type}.png"
  end

  def user_level(u)
    "Lv" + ( 2 + u.teacher_rate.to_i ).to_s
  end

  def todo_type(todo)
    case todo.source_type
    when 'TrainingPlan'
      '培训计划'
    when 'Examination'
      '考试'
    else
      'unknown todo type!'
    end
  end

  def todo_deadline(todo)
    if todo.source.nil?
      return "未知错误"
    end

    case todo.source_type
    when 'TrainingPlan'
      todo.source.feedback_deadline.to_date
    when 'Examination'
      todo.source.deadline.to_date
    else
      '无到期日期'
    end  
  end

  def todo_description(todo)
    if todo.source.nil?
      return "未知错误"
    end

    case todo.source_type
    when 'TrainingPlan'
      if todo.todo_type == 'feedback'
        todo.source.title + " 需要提供培训反馈。"
      end
    when 'Examination'
      if todo.todo_type == 'published'
        "请及时参加考试：" + todo.source.title
      elsif todo.todo_type == 'examination_pending'
        "考试管理：" + todo.source.title + "即将发布"
      elsif todo.todo_type == 'pending_finish'
        #todo.source.user.name + " 已经完成\"" + todo.source.examination.title + "\"考试"
        "\"" + todo.source.title + "\"考试已近结束,考卷需要批改"
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
      elsif todo.todo_type == 'pending_finish'
        #exam_id = todo.source.examination.id
        #feedback_id = todo.source.examination_feedback.id
        #examination_exam_feedback_path(:examination_id => exam_id, :id => feedback_id)
      end
    else
      # unknow action TODO
      ""
    end
  end

end
