class PostsController < ApplicationController

  before_action :find_post, only: [:edit, :update, :destroy, :show]
  before_action :comment, only: [:comment_store, :comment_reply, :comment_edit]
  before_action :post_index, only: [:index]

  def category_list
    @categories = Category.all
    @category = Category.where(name: params[:name]).first
    @posts = Post.where(category_id: @category.id).all
  end

  def index
    if !params[:query].blank?
      query = params[:query]
      @posts = Post.where(["title LIKE ?","%#{query}%"]).page(params[:page])
    else
      @posts = Post.order("id DESC").page(params[:page])
    end  
  end

  def create
    if !require_user
      @post = Post.new  
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
    if @post.user_id === current_user.id
      @category = Category.find(@post.category_id)
      @category_id = @category.id
    else
      flash[:alert] = "Other user post"
      redirect_to(:action => :index)
    end
  end

  def update
    if @post.update(post_param)
      flash[:notice] = "Post Update Successfully!."
      redirect_to(:action => :index)
    else
      @category_id = params[:post][:category_id] 
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Post Delete Successfully!."
      redirect_to(:action => :index)
    end
  end
  
  def show
    @posts = Post.where(user_id: @post.user_id)
    @comment = Comment.new
    @comments = Comment.order("id DESC").where(post_id: @post.id).where(parent_id: nil)
  end

  def comment_store
    @comment = Comment.new(comment_param)
    if @comment.save
      flash[:notice] = "Comment Create Successfully!."
      redirect_to '/posts/'+comment_param[:post_id]
    else
      render 'show'
    end
  end

  def comment_destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "Comment Delete Successfully!."
      redirect_to '/posts/'+@comment.post_id.to_s
    end
  end

  def comment_reply
    @comment = Comment.new(comment_param)
    if @comment.save
      flash[:notice] = "Comment Create Successfully!."
      redirect_to '/posts/'+comment_param[:post_id]
    else
      render 'show'
    end
  end

  def comment_edit
    @comment = Comment.find(params[:id])
    if @comment.update(comment_param)
      flash[:notice] = "Cpmment Update Successfully!."
      redirect_to '/posts/'+comment_param[:post_id]
    else
      render 'show'
    end
  end

  private
  def post_param
    params.require(:post).permit(:title, :category_id, :image, :description)
  end
  def comment_param
    params.require(:comment).permit(:user_id, :post_id, :comment, :parent_id)
  end
  def find_post
    @post = Post.find(params[:id])
  end
  def comment
    post = Post.find(comment_param[:post_id])
    @posts = Post.where(user_id: post.user_id)
    @comments = Comment.order("id DESC").where(post_id: post.id).where(parent_id: nil)
  end
  def post_index
    @categories = Category.all
    @last_posts = Post.order("id DESC").first(3)
  end
end
