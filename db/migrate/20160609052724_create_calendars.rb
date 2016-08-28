class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :title
      t.integer :color_R
      t.integer :color_G
      t.integer :color_B
      t.string :orner
      t.timestamps null: false
    end
  end
end
