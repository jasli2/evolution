# encoding: utf-8
module UsersHelper
  def user_avatar_path(u, type)
    u.avatar_url(type) || "defaut_user_avatar_#{type}.png"
  end

  def user_level(u)
    "Lv" + ( 2 + u.teacher_rate.to_i ).to_s
  end

  def todo_description(todo)
    case todo.source_type
    when 'TrainingPlan'
      if todo.todo_type == 'feedback'
        "培训计划：" + todo.source.title + " 需要提供培训反馈。"
      end
    else
      # unknow todo
      "unknown todo!"
    end
  end

  def todo_url(todo)
    case todo.source_type
    when 'TrainingPlan'
      if todo.todo_type == 'feedback'
        new_training_plan_feedback_path(todo.source)
      end
    else
      # unknow action TODO
      ""
    end
  end

  def notice_description(n)
    case n.source_type
    when 'TrainingPlan'
      if n.notification_type == 'all_feedback'
        "培训计划：" + n.source.title + " 所有培训学员都已经提交反馈。"
      elsif n.notification_type == 'published'
        "培训计划：" + n.source.title + " 已经发布。"
      end
    else
      "unknow notification"
    end
  end

  def notice_url(n)
    case n.source_type
    when 'TrainingPlan'
      training_plan_path(n.source)
    else
      ""
    end    
  end
end
