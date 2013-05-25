class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.references :team, null: false
      t.references :user, null: false
      t.integer :leader_id, null: false
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end
    add_index :invites, :team_id
    add_index :invites, :user_id
    add_index :invites, :leader_id
  end
end
