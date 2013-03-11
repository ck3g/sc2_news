class AddPublishedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :published, :boolean, default: true
    add_index :articles, :published
    add_column :articles, :published_at, :datetime
  end
end
