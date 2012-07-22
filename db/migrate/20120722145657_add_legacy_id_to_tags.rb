class AddLegacyIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :legacy_id, :integer
    add_index :tags, :legacy_id
  end
end
