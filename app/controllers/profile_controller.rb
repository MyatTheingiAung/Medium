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

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to '/profile/'+current_user.id.to_s, notice: 'User Update Successfully!.' }
      else
        format.js
        format.html { render :index , notice: 'User Update Failed!' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def password
    @user = current_user
    if !@user.authenticate(params[:user][:current_password])
      flash[:not_user] = "Credential don't match our record"
    else
      flash[:not_user] = ""
    end
    respond_to do |format|
      if @user && @user.authenticate(params[:user][:current_password])
        @user.update(pass_params)
        if @user.valid?(:update_password)
          format.html { redirect_to '/profile/'+current_user.id.to_s, notice: 'Password change successfully.' }
        else
          format.js 
          format.html { render :index , notice: 'Password change failed' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        format.js
        format.html { render :index , notice: 'Password change failed' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
      
  end

  def user_image_delete
    current_user.image.delete
    current_user.image_data = nil
    current_user.save
    flash[:notice] = "User photo delete successfully!"
    redirect_to '/profile/'+current_user.id.to_s
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :bio, :image, :password, :password_confirmation)
  end
  def pass_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  def find_post
    @posts = Post.where(user_id: current_user.id).page(params[:page])
  end
end
