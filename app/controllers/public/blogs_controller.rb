class Public::BlogsController < ApplicationController

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    @blog.save
    redirect_to blog_path(@blog.id)
  end

  def index
    @blogs = Blog.all.order(created_at: :desc)
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = Blog.find(params[:id])
    unless @blog.user == current_user
     redirect_to blogs_path
    end
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
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
      params.require(:blog).permit(:title, :body, :image, :man, :link, :star)
  end
end