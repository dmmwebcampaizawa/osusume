class Public::HomesController < ApplicationController
  
  def top
    @blogs = Blog.all.order(created_at: :desc)
    @tag_lists = Tag.all
  end
  
end
