class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :website
      t.text :description
      t.integer :revenue
      t.integer :price

      t.timestamps
    end
  end
end
