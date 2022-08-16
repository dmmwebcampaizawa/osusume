class Public::HomesController < ApplicationController

  def top
    @blogs = Blog.all.order(params[:sort])
    @tag_lists = Tag.all
  end

end
