# rename userole to user_role
class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :roles, :userole, :user_role 
  end
end
