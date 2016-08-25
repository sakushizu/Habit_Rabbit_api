class AddStatusToCalendarUsers < ActiveRecord::Migration
  def change
    add_column :calendar_users, :status, :int, null: false, default: 0
  end
end
