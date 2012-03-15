class ScOld::ScBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection 'sc2_md'
end
