module ApplicationHelper
  def twitterized_type(type)
    case type
      when :alert
        "alert-block"
      when :error
        "alert-error"
      when :notice
        "alert-info"
      when :success
        "alert-success"
      else
    end
  end

  def shallow_args(parent, child)
    child.try(:new_record?) ? [parent, child] : child
  end
end
