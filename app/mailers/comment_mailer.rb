class CommentMailer < ApplicationMailer
  def new_comment
    @stuff = params[:stuff]
    @user = @stuff.user
    @comment = params[:content]
    @url = "http://localhost:3000/comments/#{@stuff.id}"
    mail(to: @user.email, subject: "Your stuff '#{@stuff.stuff_name}', has been commented")
  end

  def same_stuff_commented
    @stuff = params[:stuff]
    recipients = params[:recipients]
    @url = "http://localhost:3000/comments/#{@stuff.id}"
    @comment = params[:content]
    mail(to: recipients, subject: "New comment in stuff '#{@stuff.stuff_name}'") if recipients.any?
  end
end