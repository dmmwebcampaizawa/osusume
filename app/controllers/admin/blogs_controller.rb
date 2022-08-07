class Admin::BlogsController < ApplicationController

  def index
    @blog = Blog.all
    @blogs = Blog.where(user_id: self.id)
  end

  def show
  end

  def destroy
  end
end
