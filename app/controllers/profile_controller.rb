class ProfileController < ApplicationController
  def index
    @posts = Post.where(user_id: current_user.id).page(params[:page])
    @user = current_user
  end

  def update
    @user = current_user 
    if @user.update(user_params)
      flash[:notice] = "User Update Successfully!."
      redirect_to(:action => :index)
    else
      @posts = Post.where(user_id: current_user.id).page(params[:page])
    end
  end

  def change_password
    @user = current_user
    password = params[:user][:current_password]
    if BCrypt::Password.new(current_user.password_digest) == password
      if current_user.update(pass_params)
        flash[:notice] = "Change Password Successfully!."
      end
    else
      @posts = Post.where(user_id: current_user.id).page(params[:page])
      flash[:alert] = "Change Password Failed!"
      render 'index'
    end
  end

  def user_image_delete
    image = ActiveStorage::Blob.find_by(params[:id])
    current_user.image.purge
    redirect_to(:action => :index)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :bio, :image)
  end
  def pass_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
