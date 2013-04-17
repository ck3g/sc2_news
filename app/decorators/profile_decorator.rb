class ProfileDecorator < Draper::Decorator
  delegate_all

  def battlenet_server
    result = ""
    if source.bnet_server
      alt = I18n.t("bnet_servers.#{source.bnet_server}")
      result << h.image_tag("flags/#{source.bnet_server}.png", alt: alt)
      result << alt
    end

    result.html_safe
  end

  def badge
    badge, badge_medium = source.league_parts
    if badge && badge_medium
      h.content_tag(:span, "", :class => "badge-#{badge} badge-medium-#{badge_medium}")
    end
  end
end
