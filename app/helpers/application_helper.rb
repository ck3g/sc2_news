module ApplicationHelper

  def flash_class(type)
    type == :alert ? 'error' : 'success'
  end

  def flash_icon(type)
    if type == :alert
      content_tag 'i', '', class: 'icon-warning-sign'
    else
      content_tag 'i', '', class: 'icon-info-sign'
    end
  end

  def link_to_nav(title, path)
    content_tag :li, class: ('active' if current_page?(path)) do
      link_to title, path
    end
  end

  def link_to_page_nav(permalink)
    return unless page = Page.by_permalink(permalink)

    link_to_nav page.title, page_path(permalink)
  end

  def link_to_team(user)
    if user.in_team?
      link_to_nav t('teams.my_team'), team_path(user.current_team)
    else
      link_to_nav t('teams.create'), new_team_path
    end
  end

  def index?
    params[:action] == 'index'
  end

  def show_guest_instructions?
    current_user.nil? && cookies[:hide_guest_instructions].blank?
  end

  def link_to_social(type, url)
    link_to '', url, class: "social-#{ type }", target: '_blank'
  end
end
