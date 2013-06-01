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

  def eo_markdown(text)
    options = {   
      :autolink => true, 
      :space_after_headers => true,
      #:fenced_code_blocks => true,
      :no_intra_emphasis => true
      #:hard_wrap => true,
      #:strikethrough =>true
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end

end
