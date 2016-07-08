# comments
class CreateBooks < ActiveRecord::Migration
  def up
    create_table :books do |t|
      t.string :title
      t.integer :author_id
      t.integer :publisher_id
      t.date   :published_on
      t.string :edition
      t.string :isbn
      t.integer :price
      t.string :category
      t.string :book_condition
      t.string :tag
      t.string :image_path
      t.string :sample_pages
      t.integer :no_of_pages
      t.string :binding_type
      t.timestamps null: false
      t.index [:title, :author_id, :tag, :isbn]
    end
  end

  def down
    drop_table :books
  end
end
