class AddIndexesToTaggings < ActiveRecord::Migration
  def change
    add_index :taggings, [:tagger_id, :tagger_type]
  end
end
