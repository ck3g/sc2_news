class AddDeletedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :deleted_at, :datetime
    add_index :articles, :deleted_at
    add_column :articles, :deleter_id, :integer
    add_index :articles, :deleter_id
  end
end
