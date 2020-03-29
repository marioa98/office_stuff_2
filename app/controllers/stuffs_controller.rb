class StuffsController < ApplicationController

  skip_before_action :authorized, only: [:index, :details]

  def index
    @stuff = filter_options
  end
  
  def new
    @stuff = Stuff.new
    @categories = Category.all.order(category_name: :asc)
  end

  def details
    @stuff = Stuff.find(params[:id])
  end

  def edit
    @stuff = Stuff.find(params[:id])
  end

  def update
    @stuff = Stuff.find(params[:id])
    
    respond_to do |format|
      if @stuff.update(status: stuff_params[:status].to_i)
        StuffMailer.with(stuff: @stuff).set_status.deliver_now
        format.html { redirect_to root_path }
      else
        flash[:alert] = "Error trying to set status"
        format.html { redirect_to edit_stuff_path(params[:id])}
      end
    end
  end

  def create
    @stuff = Stuff.new(category_id: stuff_params[:category_id], stuff_name: stuff_params[:stuff_name], user_id: session[:user_id])
    
    respond_to do |format|
      if @stuff.save
        StuffMailer.with(stuff: @stuff).new_request.deliver_now
        format.html { redirect_to root_path }
      else
        flash[:alert] = 'Please add the stuff name before to request.'
        format.html { redirect_to new_stuff_path }
      end
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