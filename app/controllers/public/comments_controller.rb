class Public::CommentsController < ApplicationController

  def create
    @blog = Blog.find(params[:blog_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.blog_id = @blog.id
    @comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :blog_id)
  end
end
