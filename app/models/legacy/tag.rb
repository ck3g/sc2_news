class Legacy::Tag < Legacy::Base
  self.table_name = "Tags"

  def import
    tag = ::Tag.find_or_create_by_name(self.name)
    tag.legacy_id = self.id
    tag.save
  end
end
