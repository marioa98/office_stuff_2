class UsersController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
  end
  
  def index
    @common_users = User.select(:id, :full_name, :username).where(admin: false)
  end

  def to_admin
    User.find(params[:id]).update(admin: true)
    redirect_to users_index_path
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

  def profile
    @user = User.find(session[:user_id])
  end

  def update_profile
    @user = User.find(session[:user_id])
    if @user.update(user_params)
      flash[:notice] = "Profile updated successfully"
      redirect_to my_profile_path
    else
      render 'profile'
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :username, :email, :password)
  end
end