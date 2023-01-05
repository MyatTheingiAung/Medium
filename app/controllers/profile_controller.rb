class ProfileController < ApplicationController
  def index
    @posts = Post.where(user_id: current_user.id).page(params[:page])
  end
  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "User Update Successfully!."
      redirect_to(:action => :index)
    else
      @posts = Post.where(user_id: current_user.id).page(params[:page])
      render 'index'
    end
  end

  def change_password
  end

  private
  def user_params
    params.permit(:name, :email, :bio, :image)
  end
end
