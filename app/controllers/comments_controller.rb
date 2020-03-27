class CommentsController < ApplicationController

  def index
    @stuff = Stuff.find(params[:id])
    @comments = Comment.all.where(stuff_id: params[:id]).order(created_at: :asc)
  end

  def create
    stuff = Stuff.find(params[:id])
    user = User.find(session[:user_id])

    @comment = Comment.new(stuff: stuff, comment: comments_params[:comment], user_id: user.id)
    respond_to do |format|
      if @comment.save
        CommentMailer.with(stuff: stuff, commenter: user, content: @comment).new_comment.deliver_now
        format.html {redirect_to comments_index_path(params[:id])}
      else
        flash[:alert] = 'Comments cannot be blank'
        format.html {redirect_to comments_index_path(params[:id])}
      end
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:comment)
  end
end