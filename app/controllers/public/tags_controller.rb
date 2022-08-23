class Public::TagsController < ApplicationController
  def destroy
    @tag_lists = Tag.find(params[:id])
    @tag_lists.destroy
    redirect_to admin_tag_path
  end
end
