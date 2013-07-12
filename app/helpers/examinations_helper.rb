# encoding: utf-8
module ExaminationsHelper
  def exam_state(state)
    case state
    when "pending_publish"
      "发布考试"
    when "published"
      "取消考试"
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
    else
      "#myMode"
    end
  end
end
