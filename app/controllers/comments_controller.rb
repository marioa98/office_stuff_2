class CommentsController < ApplicationController

  def index
    @stuff = Stuff.find(params[:id])
    @comments = Comment.all.where(stuff_id: params[:id]).order(created_at: :asc)
  end

  def create
    @stuff = Stuff.find(params[:id])
    @user = User.find(session[:user_id])

    @comment = Comment.new(stuff: @stuff, comment: comments_params[:comment], user_id: @user.id)
    
    if @comment.save
      CommentsJob.perform_later(@stuff, extract_recipients, @comment, @user.id)
      redirect_to comments_index_path(params[:id])
    else
      flash[:alert] = 'Comments cannot be blank'
      redirect_to comments_index_path(params[:id])
    end
  end

  private

  def extract_recipients
    commenters = Comment.where("stuff_id = ? AND user_id != ?", @stuff.id, @user.id).distinct.pluck(:user_id)

    recipients = []
    commenters.each do |user_id|
      user = User.find(user_id)
      recipients << user.email
    end

    recipients
  end

  def comments_params
    params.require(:comment).permit(:comment)
  end
end