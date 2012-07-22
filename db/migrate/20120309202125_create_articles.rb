class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.integer :views_count, :default => 0

      t.timestamps
    end

    add_index :articles, :user_id
  end
end
