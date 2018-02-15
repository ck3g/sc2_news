class AddShadowBanToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :shadow_ban_comments, :boolean, default: false
    add_column :profiles, :shadow_ban_chat, :boolean, default: false
  end
end
