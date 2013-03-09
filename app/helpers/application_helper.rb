module ApplicationHelper

  def twitterized_type(type)
    case type
      when :alert
        "warning"
      when :error
        "error"
      when :notice
        "info"
      when :success
        "success"
      else
        type.to_s
    end
  end

  def avatar_tag(user)
    image_tag "avatars/default.gif"
  end

  def link_to_nav(title, path)
    content_tag :li, :class => ("active" if current_page?(path)) do
      link_to title, path
    end
  end

  def link_to_page_nav(permalink)
    return unless page = Page.by_permalink(permalink)

    content_tag :li, :class => ("active" if current_page?(page_path(permalink))) do
      link_to page.title, page_path(permalink)
    end
  end
end
