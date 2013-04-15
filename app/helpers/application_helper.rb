module ApplicationHelper

  def flash_class(type)
    if type == :alert
      "error"
    else
      "success"
    end
  end

  def flash_icon(type)
    if type == :alert
      content_tag "i", "", :class => "icon-warning-sign"
    else
      content_tag "i", "", :class => "icon-info-sign"
    end
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

  def index?
    params[:action] == "index"
  end
end
