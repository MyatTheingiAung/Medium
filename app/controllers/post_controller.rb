class PostController < ApplicationController
  def index
    @posts = Post.order("id DESC").page(params[:page])
    @categories = Category.all
    @last_posts = Post.order("id DESC").first(3)
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
      flash[:notice] = "Post Create Successfully!."
      redirect_to(:action => :index)
    else
      @category_id = params[:post][:category_id]
      render 'create'
    end
  end

  def edit
    @post = Post.find(params[:id])
    @category = Category.find(@post.category_id)
    @category_id = @category.id
  end
  
  def show
    @post = Post.find(params[:id])
    @posts = Post.where(user_id: @post.user_id)
    @post_count = @posts.count
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_param)
      flash[:notice] = "Post Update Successfully!."
      redirect_to(:action => :index)
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Post Delete Successfully!."
      redirect_to(:action => :index)
    end
  end

  def category_list
    @categories = Category.all
    @category = Category.where(name: params[:name]).first
    @posts = Post.where(category_id: @category.id).all
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
