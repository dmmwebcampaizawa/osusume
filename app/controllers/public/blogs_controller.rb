class Public::BlogsController < ApplicationController

  def new
    @blog = Blog.new
    @tag_lists = Tag.all
  end

  def show
    @blog = Blog.find(params[:id])
    @blog = Blog.find_by(id: params[:id])
    @tag_lists = Tag.all
    @user = @blog.user
    if user_signed_in? && current_user.id == @blog.user_id
      @comment = current_user.comments.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    tag_list = params[:blog][:tag_ids].split(',')
    if @blog.save
    @blog.save_tags(tag_list)
    redirect_to blog_path(@blog.id)
    else
    @tag_lists = Tag.all
    render :new
    
    end
  end

   def index
    params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @blogs = @tag.blogs.order(created_at: :desc)
    @tag_lists = Tag.all
   end

  def edit
    @blog = Blog.find(params[:id])
    @tag_list =@blog.tags.pluck(:tagname).join(",")
    @tag_lists = Tag.all
    unless @blog.user == current_user
     redirect_to root_path
    end
  end

  def update
    @blog = Blog.find(params[:id])
    tag_list = params[:blog][:tag_ids].split(',')
    if @blog.update(blog_params)
      @blog.save_tags(tag_list)
      redirect_to blog_path(@blog.id)
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    if @blog.user == current_user
      @blog.destroy
    redirect_to top_path, notice: "商品を削除しました。"
    else
     redirect_to top_path
    end
  end

  def electric
    @electric = Blog.where(genre:"電化製品").order(created_at: :desc)
    @tag_lists = Tag.all
  end

  def interior
    @blog = Blog.all.order(created_at: :desc)
    @interior = Blog.where(genre:"インテリア")
    @tag_lists = Tag.all
  end

  def tableware
    @blog = Blog.all.order(created_at: :desc)
    @tableware = Blog.where(genre:"食器")
    @tag_lists = Tag.all
  end

  def food
    @blog = Blog.all.order(created_at: :desc)
    @food = Blog.where(genre:"食品")
    @tag_lists = Tag.all
  end


  def search_category
    # @keyword = params[:keyword]
    # @book=Book.new
    # @books = Book.search(params[:keyword])
    # if
    # @model = "book"
    # end
  end


  private

  def blog_params
      params.require(:blog).permit(:title, :body, :image, :man, :link, :star, :genre, :tagname)
  end
end