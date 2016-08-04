class InvitationUser < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :user

  before_create :set_default_status

  enum status: %i(inviting joined rejected)

  private

  def set_default_status
    self.status = 'inviting'
  end
end
