class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.integer :user_id
      t.text :title, null: false, default: ""
      t.text :body, null: false, default: ""
      t.text :man, null: false, default: ""
      t.text :link, null: false, default: ""
      t.float :rate

      t.timestamps
    end
  end
end
