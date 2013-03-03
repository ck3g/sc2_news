class Legacy::NewsTag < Legacy::Base
  self.table_name = "NewsInTags"

  belongs_to :legacy_tags, class_name: "Legacy::Tag", foreign_key: "tag_id"
  belongs_to :legacy_news, class_name: "Legacy::News", foreign_key: "news_id"
end
