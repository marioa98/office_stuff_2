class UsersController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]

  def new
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :username, :password)
  end
end