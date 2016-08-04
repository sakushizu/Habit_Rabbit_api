class CreateInvitationUsers < ActiveRecord::Migration
  def change
    create_table :invitation_users do |t|
      t.integer :calendar_id
      t.integer :user_id
      t.integer :status
      t.timestamps null: false
    end
  end
end
