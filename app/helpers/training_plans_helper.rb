# encoding: utf-8
module TrainingPlansHelper
  def training_plan_state(tp)
    case tp.state
    when 'created'
      '已创建'
    when 'finished'
      '已完成'
    when 'cancelled'
      '已取消'
    when 'pending_feedback'
      '等待学员反馈'
    when 'pending_publish'
      '等待发布'
    when 'started'
      '进行中'
    else
      '未知状态'
    end
  end
end
