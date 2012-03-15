class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :old_id, :string
    add_column :users, :user_name, :string


  end
end
