# encoding: utf-8
module QuestionsHelper

  def judge_type(type)
      qtype = ["choice", "judgement", "dialogical"]
      mtype =  type.to_s
      if mtype.blank?
        false
      else
        qtype.include?(mtype)
      end
  end

  def get_question_type(type)
    mtype =  type.to_s
    case mtype
    when "choice"
      "选择题"
    when "judgement"
      "判断题"
    when "dialogical"
      "简答题"
    else
      "添加新考题"
    end
  end

end
