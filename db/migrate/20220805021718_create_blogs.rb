class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.integer :user_id
      t.text :title, null: false
      t.text :body, null: false
      t.text :man, null: false
      t.text :link, null: false
      t.float :rate

      t.timestamps
    end
  end
end
