class RenameStatusColumnNotification < ActiveRecord::Migration
  def change
    rename_column :notifications, :status, :seen
  end
end
