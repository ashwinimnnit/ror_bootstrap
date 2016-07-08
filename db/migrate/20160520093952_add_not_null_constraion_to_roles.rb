class AddNotNullConstraionToRoles < ActiveRecord::Migration
  def change
    change_column :roles, :user_id, :integer, null: false
    change_column :roles, :user_role, :integer, null: false
  end
end
