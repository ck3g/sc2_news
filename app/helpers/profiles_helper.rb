module ProfilesHelper
  def profile_attribute_block(title, value)
    content_tag :p do
      "<strong>#{title}:</strong>".html_safe + " #{value_to_text(value)}"
    end
  end

  def value_to_text(value)
    if value.kind_of?(Time) || value.kind_of?(Date)
      l(value, format: :long)
    elsif value
      value
    else
      "-"
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
