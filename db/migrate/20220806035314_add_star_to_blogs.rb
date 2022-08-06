class AddStarToBlogs < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :star, :float
  end
end
