class AddRoleIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :role_id, :integer
  end
end
