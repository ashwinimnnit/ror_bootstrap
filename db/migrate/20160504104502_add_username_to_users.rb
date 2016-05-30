class AddUsernameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :user_name, :string, unique: true
    add_index :users, :user_name
  end

  def down
    remove_column :users, :user_name
  end
end
