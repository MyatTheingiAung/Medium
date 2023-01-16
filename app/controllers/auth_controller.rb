class AuthController < ApplicationController

  def login
    if session[:user_id]
      redirect_to root_path
    end
  end

  def user_login
    if params[:session][:email].blank?
      flash[:error_email] = "Email can't be blank"
    else
      flash[:error_email] = ""
      flash[:email] = params[:session][:email]
    end
    if params[:session][:password].blank?
      flash[:error_password] = "Password can't be blank"
    else
      flash[:error_password]=""
    end
    
    @user = AuthService.findUser(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      flash[:notice] = "Logged in successfully!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:user_alert] = "Credential do not match our record!"
      render 'login'
    end
  end
  
  def register
    if !current_user
      @user = AuthService.newUser
    else
      redirect_to root_path
    end
  end

  def create
    @user = AuthService.createUser(user_params)
    if @user.save
      flash[:notice] = "Register Successfully!."
      redirect_to(:action => :login)
    else
      render 'register'
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio)
  end
end
