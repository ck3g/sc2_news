class AddTweetedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :tweeted, :boolean, default: false
    add_index :articles, :tweeted
  end
end
