class CommentMailer < ApplicationMailer
  
  def new_comment
    @stuff = params[:stuff]
    @user = @stuff.user
    @comment = params[:content]
    @url = "http://localhost:3000/comments/#{@stuff.id}"
    mail(to: @user.email, subject: "New comment in '#{@stuff.stuff_name}'")
  end
end