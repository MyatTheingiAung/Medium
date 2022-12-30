class PostController < ApplicationController
  def index
    @posts = Post.page(params[:page])
    @categories = Category.all
    @last_posts = Post.last(3)
  end
  def create
    if session[:user_id]
      @post = Post.new
    else
      redirect_to '/'
    end
  end
  def store
    @post = Post.new(post_param)
    @post.user_id = session[:user_id]
    if @post.save
      flash[:success] = "Post Create Successfully!."
      redirect_to(:action => :index)
    else
      flash[:category_id] = params[:post][:category_id]
      render 'create'
    end
  end
  def show
  end
  def category_list
    @categories = Category.all
    @category = Category.where(name: params[:name]).first
  end
  def search
    @query = params[:query]
    @posts = Post.where(["title LIKE ?","%#{@query}%"]).page(params[:page])
    @categories = Category.all
    @last_posts = Post.last(3)
    render 'index'
  end

  private
  def post_param
    params.require(:post).permit(:title, :category_id, :image, :description)
  end
end
