module ArticlesHelper
  def article_hint(tags, description)
    tags = [tags] unless tags.is_a? Array

    hint_tags = tags.map do |tag_name|
      content_tag :span, "<#{tag_name}>", class: "label label-info"
    end.localize(I18n.locale).to_sentence.html_safe

    content_tag :p do
      "#{hint_tags} - #{description}".html_safe
    end
  end
end
