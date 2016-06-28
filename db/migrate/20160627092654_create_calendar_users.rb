class CreateCalendarUsers < ActiveRecord::Migration
  def change
    create_table :calendar_users do |t|
      t.integer :calendar_id
      t.integer :user_id

      # t.timestamps null: false
    end
  end
end
