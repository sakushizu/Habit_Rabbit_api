class AddStampImageToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :stamp_image, :string
  end
end
