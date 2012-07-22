class Legacy::News < Legacy::Base
  self.table_name = "News"
  self.inheritance_column = :_type_disabled

  def self.import(legacy_id)

  end
end
