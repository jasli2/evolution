#encoding: utf-8
module CompetenciesHelper
  def level_name(c)
    case c
    when 1
      "助理级别"
    when 2
      "经理级别"
    when 3
      "高级经理级别"
    when 4
      "资深经理级别"
    else
      "未知级别"
    end
  end
end
