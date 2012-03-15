class ScOld::News < ScOld::ScBase
  set_table_name "News"
  self.inheritance_column = :_type_disabled
end
