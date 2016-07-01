class CreateStampedDates < ActiveRecord::Migration
  def change
    create_table :stamped_dates do |t|
      t.datetime :date
      t.integer :calendar_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
