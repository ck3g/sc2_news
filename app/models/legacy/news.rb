class Legacy::News < Legacy::Base
  set_table_name "News"
  self.inheritance_column = :_type_disabled
end
