class CreateMemos < ActiveRecord::Migration
  def change
    create_table :memos do |t|
      t.text :memo
      t.integer :calendar_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
