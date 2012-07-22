class AddIpAddressToComments < ActiveRecord::Migration
  def change
    add_column :comments, :ip_address, :string
    add_index :comments, :ip_address
  end
end
