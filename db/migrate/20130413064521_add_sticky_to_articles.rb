class AddStickyToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :sticky, :boolean, default: false
    add_index :articles, :sticky
  end
end
