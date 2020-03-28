class CommentMailer < ApplicationMailer
  
  def initialize
    @url = "http://localhost:3000"
  end

  def new_comment
    @stuff = params[:stuff]
    @user = @stuff.user
    @comment = params[:content]
    @url += "/comments/#{@stuff.id}"
    mail(to: @user.email, subject: "New comment in '#{@stuff.stuff_name}'")
  end
end