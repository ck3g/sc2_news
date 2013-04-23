module ArticlesHelper
  def article_hint(tags, description)
    tags = [tags] unless tags.is_a? Array

    hint_tags = tags.map do |tag_name|
      content_tag :span, "<#{ tag_name }>", class: 'label label-info'
    end.localize(I18n.locale).to_sentence.html_safe

    content_tag :p do
      "#{ hint_tags } - #{ description }".html_safe
    end
  end

  def article_hint_by_rule(rule)
    article_hint rule.first, t("hint.#{ rule.first.first }_desc",
                               icon: image_tag(rule.last))
  end

  def cut(text)
    text.split(Article::CUTTER).first
  end

  def replace_tags(text)
    str = text.gsub Article::CUTTER, ''

    ReplaceIconsStrategy.rules.each do |tags, icon|
      tags.each do |tag_name|
        str.gsub! "&lt;#{ tag_name }&gt;", image_tag(icon)
      end
    end

    str
  end

  def formatted(text, cut_text = false)
    text = cut(text) if cut_text
    replace_tags text
  end

  def unpublished_prefix(article)
    unless article.published?
      content_tag :span, "[#{ t(:unpublished) }]", class: 'unpublished'
    end
  end

  def deleted_class(article)
    'deleted' if article.deleted?
  end

  def deleted_title(article)
    t(:deleted) if article.deleted?
  end
end
