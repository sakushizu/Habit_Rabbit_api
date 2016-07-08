class Calendar < ActiveRecord::Base
  has_many :calendar_users
  has_many :stampd_dates
  has_many :users, through: :calendar_users

  mount_uploader :stamp_image, AvatarUploader

  validates :title, presence: true

end
