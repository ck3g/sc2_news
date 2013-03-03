class Legacy::Tag < Legacy::Base
  self.table_name = "Tags"

  has_many :legacy_news_tags, class_name: "Legacy::NewsTag"
  has_many :legacy_news, through: :legacy_news_tags

  def import
    tag = ::Tag.find_or_create_by_name(self.name)
    tag.legacy_id = self.id
    tag.save
  end
end
