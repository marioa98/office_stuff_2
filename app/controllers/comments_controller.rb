class CommentsController < ApplicationController

  def index
    @stuff = Stuff.find(params[:id])
    @comments = Comment.all.where(stuff_id: params[:id]).order(created_at: :asc)
  end

  def create
    stuff = Stuff.find(params[:id])

    @comment = Comment.new(stuff: stuff, comment: comments_params[:comment], user_id: session[:user_id])
    if @comment.save
      redirect_to comments_index_path(params[:id])
    else
      flash[:alert] = 'Comments cannot be blank'
      redirect_to comments_index_path(params[:id])
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:comment)
  end
end