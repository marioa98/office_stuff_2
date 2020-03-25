class CommentsController < ActionController::Base
  def index
    @stuff = Stuff.find(params[:id])
    @comments = Comment.all.where(stuff_id: params[:id]).order(created_at: :asc)
  end

  def create
    user = User.first
    stuff = Stuff.find(params[:id])
    Comment.create!(stuff: stuff, comment: comments_params[:comment], user: user)
    redirect_to comments_index_path(params[:id])
  end

  private

  def comments_params
    params.require(:comment).permit(:comment)
  end
end