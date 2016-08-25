class Calendar < ActiveRecord::Base
  belongs_to :user
  has_many :calendar_users
  has_many :status_inviting, -> { where status: CalendarUser.statuses['inviting'] }, class_name: 'CalendarUser'
  has_many :status_joined, -> { where status: CalendarUser.statuses['joined'] }, class_name: 'CalendarUser'
  has_many :status_reject, -> { where status: CalendarUser.statuses['rejected'] }, class_name: 'CalendarUser'

  has_many :inviting, through: :status_inviting, source: :user
  has_many :joined, through: :status_joined, source: :user
  has_many :reject, through: :status_reject, source: :user

  has_many :stampd_dates


  mount_uploader :stamp_image, AvatarUploader

  validates :title, presence: true

  def users_can_be_invited
    User.all - joined
  end

  def except_owner(users, current_user)
    users.reject { |user|
      user == current_user
    }
  end

  def update_with_asocciated_users(calendar_params, invitation_user_ids, joined_user_ids)
    update(calendar_params)

    calendar_users.destroy_all
    unless invitation_user_ids.empty?
      invitationUser_ids = invitation_user_ids.split(",")
      invitationUser_ids.each do |user_id|
        calendar_users.create(user_id: user_id)
      end
    end
    unless joined_user_ids.empty?
      joined_ids = joined_user_ids.split(",")
      joined_ids.each do |user_id|
        calendar_users.create(user_id: user_id, status: 'joined')
      end
    end
  end



end
