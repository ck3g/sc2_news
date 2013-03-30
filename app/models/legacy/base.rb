class Legacy::Base < ActiveRecord::Base
  self.abstract_class = true
  establish_connection 'sc2_md'

  LOG_FILE = "#{Rails.root}/log/import.log"
end
