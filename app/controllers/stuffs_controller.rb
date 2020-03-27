class StuffsController < ApplicationController

  skip_before_action :authorized, only: [:index]

  def index
    @stuff = filter_options
  end
  
  def new
    @stuff = Stuff.new
    @categories = Category.all.order(category_name: :asc)
  end

  def edit
    @stuff = Stuff.find(params[:id])
  end

  def update
    Stuff.find(params[:id]).update!(status: stuff_params[:status].to_i)
    redirect_to root_path
  end

  def create
    @stuff = Stuff.new(category_id: stuff_params[:category_id], stuff_name: stuff_params[:stuff_name], user_id: session[:user_id])
    
    if @stuff.save
      redirect_to root_path
    else
      flash[:alert] = 'Please add the stuff name before to request.'
      redirect_to new_stuff_path
    end
  end

  private

  def stuff_params
    params.require(:stuff).permit(:category_id, :stuff_name, :status, :user)
  end
  
  def filter_options
    if params.key?(:filter)
      status = params[:filter][:status].downcase
      category_name = params[:filter][:category]
      category = Category.find_by(category_name: category_name)

      if status == 'all' && category_name == 'All'
        Stuff.all
      elsif status != 'all' && category_name == 'All'
        Stuff.all.where(status: status)
      elsif status == 'all' && category_name != 'All'
        Stuff.all.where(category: category)
      else
        Stuff.all.where(category: category,status: status)
      end
    else
      Stuff.all
    end
  end
end