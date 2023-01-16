class ProfileController < ApplicationController
  before_action :find_post, only: [:update, :change_password]
  
  def index
    if !require_user
      @user = ProfilesService.findUser(params[:id])
      @posts = ProfilesService.findPost(params[:id], params[:page])
    end
  end

  def update
    @user = current_user
    isUpdateProfile = ProfilesService.updateProfile(@user, user_params)
    respond_to do |format|
      if isUpdateProfile
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
    userAuthenticate = ProfilesService.userAuthenticate(@user,params[:user][:current_password])
    if !userAuthenticate
      flash[:not_user] = "Credential don't match our record"
    else
      flash[:not_user] = ""
    end
    respond_to do |format|
      if @user && userAuthenticate
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
    userImageDelete = ProfilesService.userImageDelete(current_user)
    if userImageDelete 
      flash[:notice] = "User photo delete Successfully!."
      redirect_to '/profile/'+current_user.id.to_s
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :bio, :image)
  end
  def pass_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  def find_post
    @posts = ProfilesService.findPost(current_user.id, params[:page])
  end
end
