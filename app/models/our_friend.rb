class OurFriend < ActiveRecord::Base
  attr_accessible :title, :url, :visible, :image, :remote_image_url

  mount_uploader :image, FriendBannerUploader

  validates :title, :url, presence: true

  scope :visible, -> { where(visible: true) }
end
