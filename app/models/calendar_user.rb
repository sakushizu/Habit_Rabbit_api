class CalendarUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :calendar

  enum status: %i(inviting joined rejected)


end
