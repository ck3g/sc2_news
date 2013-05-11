class CreateOurFriends < ActiveRecord::Migration
  def change
    create_table :our_friends do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :image
      t.boolean :visible, default: true

      t.timestamps
    end
    add_index :our_friends, :visible
  end
end
