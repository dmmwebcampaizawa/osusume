class Public::BlogsController < ApplicationController

  def new
    @blog = Blog.new
    @tag_lists = Tag.all
  end

  def show
    @blog = Blog.find(params[:id])
    @blog = Blog.find_by(id: params[:id])
    @comment = current_user.comments.new
    @tag_lists = Tag.all
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    tag_list = params[:blog][:tagname].split(',')
    @blog.save
    @blog.save_blogs(tag_list)
    redirect_to blog_path(@blog.id)
  end

   def index
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @blogs = @tag.blogs.order(created_at: :desc)
    else
      @blogs = Blog.all.order(created_at: :desc)
    end
    @tag_lists = Tag.all
   end


  def edit
    @blog = Blog.find(params[:id])
    @tag_lists = Tag.all
    unless @blog.user == current_user
     redirect_to blogs_path
    end
  end

  def update
    @blog = Blog.find(params[:id])
    tag_list = params[:blog][:tagname].split(',')
    if @blog.update(blog_params)
      @blog.save_blogs(tag_list)
      redirect_to blog_path(@blog.id)
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "商品を削除しました。"
  end

  def electric
    @blog = Blog.all.order(created_at: :desc)
    @electric = Blog.where(genre:"電化製品")
  end

  def interior
    @blog = Blog.all.order(created_at: :desc)
    @interior = Blog.where(genre:"インテリア")
  end

  def tableware
    @blog = Blog.all.order(created_at: :desc)
    @tableware = Blog.where(genre:"食器")
  end

  def food
    @blog = Blog.all.order(created_at: :desc)
    @food = Blog.where(genre:"食品")
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
      params.require(:blog).permit(:title, :body, :image, :man, :link, :star, :genre)
  end
end