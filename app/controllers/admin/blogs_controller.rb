class Admin::BlogsController < ApplicationController

  def index
    @blog = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def tag
    @tag_lists = Tag.all
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to admin_blogs_path, notice: "商品を削除しました。"
  end
end
