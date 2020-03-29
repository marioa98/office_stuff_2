class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :login]

  def new
    @user = User.new
  end

  def login
    @user = User.find_by("username = ? OR email = ?", user_params[:username_or_email], user_params[:username_or_email])

    if @user&.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:alert] = "Username or password invalid. Please fill correctly"
      render 'new'
    end
  end

  def logout
    session.delete(:user_id)
    @user = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username_or_email, :password)
  end
end