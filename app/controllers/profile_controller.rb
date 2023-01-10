class ProfileController < ApplicationController
  before_action :find_post, only: [:update, :change_password]
  
  def index
    if !require_user
      @user = User::find(params[:id])
      @posts = Post.where(user_id: params[:id]).page(params[:page])
    end
  end

  def update
    @user = current_user 
    if @user.update(user_params)
      flash[:notice] = "User Update Successfully!."
      redirect_to(:action => :index)
    else
      render 'index'
    end
  end

  def password
    @user = current_user
    password = params
    if @user && @user.authenticate(params[:user][:current_password])
      respond_to do |format|
        if current_user.update(pass_params)
          format.html { redirect_to '/profile/'+current_user.id.to_s, notice: 'Password change successfully.' }
        else
          format.js
          # format.html { redirect_to '/profile/'+current_user.id.to_s, notice: 'Password change failed' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
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
  def find_post
    @posts = Post.where(user_id: current_user.id).page(params[:page])
  end
end
