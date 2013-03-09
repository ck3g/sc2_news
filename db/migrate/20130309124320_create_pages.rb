class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :permalink, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.string :description
      t.string :keywords
      t.boolean :enabled, null: false, default: false

      t.timestamps
    end
    add_index :pages, :permalink, unique: true
    add_index :pages, :title, unique: true
    add_index :pages, :enabled
  end
end
