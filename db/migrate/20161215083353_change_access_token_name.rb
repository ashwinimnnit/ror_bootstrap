class ChangeAccessTokenName < ActiveRecord::Migration
  def change
    rename_column :users, :access_token, :accesstoken
  end
end
