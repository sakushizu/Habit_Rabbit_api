class RenameOrnerColumnToCalendars < ActiveRecord::Migration
  def change
    rename_column :calendars, :orner, :user_id
  end
end
