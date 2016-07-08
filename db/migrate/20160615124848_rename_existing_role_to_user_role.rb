class RenameExistingRoleToUserRole < ActiveRecord::Migration
  def change
    rename_table :existing_roles, :user_roles
  end
end
