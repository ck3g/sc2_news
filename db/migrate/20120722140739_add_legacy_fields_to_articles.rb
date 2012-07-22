class AddLegacyFieldsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :ip_address, :string
    add_index :articles, :ip_address
    add_column :articles, :legacy_id, :integer
    add_index :articles, :legacy_id
  end
end
