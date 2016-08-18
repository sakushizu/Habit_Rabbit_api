class Calendar < ActiveRecord::Base
  belongs_to :user

  has_many :calendar_users
  has_many :joined_users, through: :calendar_users, source: :user

  has_many :invitation_users
  has_many :inviting_users, through: :invitation_users, source: :user

  has_many :stampd_dates

  mount_uploader :stamp_image, AvatarUploader

  validates :title, presence: true

end
