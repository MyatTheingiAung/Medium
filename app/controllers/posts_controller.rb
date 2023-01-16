class PostsController < ApplicationController

  before_action :find_post, only: [:edit, :update, :destroy, :show]
  before_action :comment, only: [:comment_store, :comment_reply, :comment_edit]
  before_action :post_index, only: [:index]
  before_action :find_comment, only: [:comment_edit, :comment_destroy]

  def category_list
    @categories = PostsService.categoryAll
    @category = PostsService.category(params[:name])
    @posts = PostsService.postByCategory(@category.id)
  end

  def index
    if !params[:query].blank?
        @posts = PostsService.search(params[:query],params[:page])
    else
        @posts = PostsService.listAll(params[:page])
    end 
  end

  def create
    if !require_user
      @post = PostsService.newPost
    end
  end

  def store
    @post = PostsService.createPost(post_param, session[:user_id])
    if @post.save
      flash[:notice] = "Post Create Successfully!."
      redirect_to(:action => :index)
    else
      @category_id = params[:post][:category_id]
      render :create
    end
  end

  def edit
    if @post.user_id === current_user.id
      @category_id = @post.category_id
    else
      flash[:alert] = "Other user post"
      redirect_to(:action => :index)
    end
  end

  def update
    isUpdatePost = PostsService.updatePost(@post,post_param)
    if isUpdatePost
      flash[:notice] = "Post Update Successfully!."
      redirect_to(:action => :index)
    else
      @category_id = params[:post][:category_id] 
      render 'edit'
    end
  end

  def destroy
    isDeletePost = PostsService.deletePost(@post)
    if isDeletePost
      flash[:notice] = "Post Delete Successfully!."
      redirect_to(:action => :index)
    end
  end
  
  def show
    @posts = PostsService.post(@post.user_id)
    @last_posts = PostsService.limitPost(4)
    @comment = PostsService.newComment
    @comments = PostsService.CommentAll(@post.id)
  end

  def comment_store
    @comment = PostsService.createComment(comment_param)
    if @comment.save
      flash[:notice] = "Comment Create Successfully!."
      redirect_to '/posts/'+comment_param[:post_id]
    else
      render 'show'
    end
  end

  def comment_destroy
    isDeleteComment = PostsService.deleteComment(@comment)
    if isDeleteComment
      flash[:notice] = "Comment Delete Successfully!."
      redirect_to '/posts/'+@comment.post_id.to_s
    end
  end

  def comment_reply
    isSaveComment = PostsService.createComment(comment_param)
    if isSaveComment
      flash[:notice] = "Comment Create Successfully!."
      redirect_to '/posts/'+comment_param[:post_id]
    else
      render 'show'
    end
  end

  def comment_edit
    isUpdateComment = PostsService.updateComment(@comment,comment_param)
    if isUpdateComment
      flash[:notice] = "Cpmment Update Successfully!."
      redirect_to '/posts/'+comment_param[:post_id]
    else
      render 'show'
    end
  end

  private
  def post_param
    params.require(:post).permit(:title,:user_id, :category_id, :image, :description)
  end
  def comment_param
    params.require(:comment).permit(:user_id, :post_id, :comment, :parent_id)
  end
  def find_post
    @post = PostsService.findPost(params[:id])
  end
  def find_comment
    @comment = PostsService.findComment(params[:id])
  end
  def comment
    @post = PostsService.findPost(comment_param[:post_id])
    @posts = PostsService.post(@post.user_id)
    @last_posts = PostsService.limitPost(4)
    @comments = PostsService.CommentAll(@post.id)
  end
  def post_index
    @categories = PostsService.categoryAll
    @last_posts = PostsService.limitPost(4)
  end
end
