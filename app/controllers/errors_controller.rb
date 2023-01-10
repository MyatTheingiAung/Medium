class ErrorsController < ApplicationController
  def not_found
    if current_user
      redirect_to login_path
    else
      redirect_to root_path
    end
  end

  def internal_server_error
    if current_user
      redirect_to login_path
    else
      redirect_to root_path
    end
  end
end
