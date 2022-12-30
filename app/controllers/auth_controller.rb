class AuthController < ApplicationController
  def login
  end
  def userLogin
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
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged in successfully."
      redirect_to '/'
    else
      flash[:alert] = "Credential do not match our record."
      render 'login'
    end
  end
  def register
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:register] = "Register Successfully!."
      redirect_to(:action => :login)
    else
      render 'register'
    end
  end
  def logout
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to '/'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio)
  end
end
