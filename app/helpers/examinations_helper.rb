# encoding: utf-8
module ExaminationsHelper
  def exam_state(state)
    case state
    when "pending_publish"
      "发布考试"
    when "published"
      "取消考试"
    when "finished"
      "查看考试结果"
    else
      "未知状态"
    end
  end

  def exam_progress(state)
    case state
    when "pending_publish"
      "待发布"
    when "published"
      "已发布"
    when "finished"
      "已结束"
    when "cancelled"
      "已取消"
    else
      "未知状态"
    end
  end

  def exam_state_action(exam, user)
    case exam.state
    when "pending_publish"
      confirm_publish_examination_path(exam.id)
    when "published"
      "#myMode"
    when "finished"
      result_examination_path(exam)
    else
      "#myMode"
    end
  end

  def student_exam_state(exam, user)
    todo =  exam.find_user_todo(user.id)
    if todo
      todo.finished? ? "已参加考试" : "报名考试"
    else
      "未知状态"
    end
  end

  def student_exam_todo_url(exam, user)
    todo =  exam.find_user_todo(user.id)
    if todo
      todo.finished? ? "#exam" : new_examination_exam_feedback_path(exam)
    else
      "#exam"
    end
  end

  def get_question_index(exam, question, type)
    case type
    when "choice"
      exam.get_choice_question.index(question) + 1
    when "judgement"
      exam.get_judgement_question.index(question) + 1
    when "dialogical"
      exam.get_dialogical_question.index(question) + 1
    else
      0
    end

  end
end
