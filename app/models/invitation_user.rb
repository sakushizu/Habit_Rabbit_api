class InvitationUser < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :user

  before_create :set_default_status

  enum status: %i(inviting joined rejected)

  scope :change_calendar_status, ->(user_id, calendar_id) { find_by(user_id: user_id, calendar_id: calendar_id) }
  scope :inviting_calendar, -> { where(status: 'inviting') }


  private

  def set_default_status
    self.status = 'inviting'
  end
end
