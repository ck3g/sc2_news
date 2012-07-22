class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :country_id
      t.string :race
      t.string :bnet_name
      t.string :bnet_server
      t.string :league
      t.integer :experience
      t.string :first_name
      t.string :last_name
      t.text :details
      t.string :avatar_style
      t.integer :achievements
      t.integer :rank
      t.integer :points
      t.integer :wins
      t.integer :loses
      t.string :win_rate
      t.string :profile_url
      t.datetime :synchronized_at


      t.timestamps
    end

    add_index :profiles, :user_id
    add_index :profiles, :country_id
  end
end
