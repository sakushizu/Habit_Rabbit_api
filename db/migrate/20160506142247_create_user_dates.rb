class CreateUserDates < ActiveRecord::Migration
  def change
    create_table :user_dates do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.integer :calendar_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
