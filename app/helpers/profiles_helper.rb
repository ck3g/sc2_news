module ProfilesHelper
  def profile_attribute_block(title, value)
    content_tag :p do
      "<strong>#{title}:</strong>".html_safe + " #{(value  if value.present?)}"
    end
  end

  def avatar_html(profile)
    if profile.avatar_style?
      content_tag :div, "", style: profile.avatar_style
    else
      image_tag "bnet/avatar.gif", alt: "Avatar", size: "90x90"
    end
  end
end
