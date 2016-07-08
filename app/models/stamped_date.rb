class StampedDate < ActiveRecord::Base
  belongs_to :user
  belongs_to :calendar

  scope :stamped_dates, ->(user, calendar_id) { where(user_id: user, calendar_id: calendar_id) }
end
