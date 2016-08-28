class Memo < ActiveRecord::Base
  scope :calendar_memo, ->(user_id, calendar_id) { where(user_id: user_id, calendar_id: calendar_id) }
end
