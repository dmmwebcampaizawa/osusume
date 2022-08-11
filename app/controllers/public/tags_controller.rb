class Public::TagsController < ApplicationController
  def destroy
    @tag_lists = Tag.find(params[:id])
    @tag_lists.destroy
    redirect_back(fallback_location: root_path)
  end
end
