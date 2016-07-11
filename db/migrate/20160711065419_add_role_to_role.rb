class AddRoleToRole < ActiveRecord::Migration
  def change
    remove_column :roles, :user_id
    remove_column :roles, :user_role
    add_column :roles, :name, :string
  end
end
