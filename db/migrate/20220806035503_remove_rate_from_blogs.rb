class RemoveRateFromBlogs < ActiveRecord::Migration[6.1]
  def change
    remove_column :blogs, :rate, :float
  end
end
