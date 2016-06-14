class CreateExistingRoles < ActiveRecord::Migration
  def change
    create_table :existing_roles do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
