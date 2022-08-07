class AddGenreToBlogs < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :genre, :text
  end
end
