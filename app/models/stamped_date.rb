class StampedDate < ActiveRecord::Base
  belongs_to :users
  belongs_to :calendars
end
