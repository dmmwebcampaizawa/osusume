class Public::UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
    @tag_lists = Tag.all
  end

  def edit
    @user = User.find(current_user.id)
    @tag_lists = Tag.all
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def unsubscribe
    @user = current_user
    @tag_lists = Tag.all
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to top_path
  end

   private

  def user_params
    params.require(:user).permit(:email, :name, :is_deleted, :profile_image, :introduction)
  end

end
