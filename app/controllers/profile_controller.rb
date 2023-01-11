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
    if params[:user][:current_password].blank?
      flash[:current] = "Old password can't blank"
    elsif !@user.authenticate(params[:user][:current_password])
      flash[:current] = ""
      flash[:not_user] = "Credential do not match our record"
    else
      flash[:not_user] = ""
    end
    if params[:user][:password].blank?
      flash[:password] = "New password can't blank"
    else
      flash[:password] = ""
    end
    if params[:user][:password_confirmation].blank?
      flash[:password_confirmation] = "Password confirmation can't blank"
    else
      flash[:password_confirmation] = ""
    end
    if !params[:user][:password].blank? && !params[:user][:password_confirmation].blank?
      if params[:user][:password] != params[:user][:password_confirmation]
        flash[:unmatch_password] = "Password and password confirmation don't match"
      else
        flash[:unmatch_password] = ""
      end
    end
    
    respond_to do |format|
      if @user.update(pass_params)
        format.html { redirect_to '/profile/'+current_user.id.to_s, notice: 'Password change successfully.' }
      else
        format.js
        format.html { render :index , notice: 'Password change failed' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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
