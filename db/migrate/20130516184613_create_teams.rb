class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :leader_id
      t.string :name, null: false
      t.string :slug, null: false
      t.string :logo
      t.text :description

      t.timestamps
    end
    add_index :teams, :leader_id, :unique => true
    add_index :teams, :slug, :unique => true
  end
end
