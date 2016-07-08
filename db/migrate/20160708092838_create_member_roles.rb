class CreateMemberRoles < ActiveRecord::Migration
  def change
    create_table :member_roles do |t|
      t.integer :user_id
      t.integer :role_id
      t.timestamps null: false
    end
  end
end
