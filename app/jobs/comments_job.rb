class CommentsJob < ApplicationJob
  queue_as :default

  def perform(stuff, recipients, comment)
    SameStuffCommentedService.new.send_email(stuff, recipients, comment)
    NewCommentService.new.send_email(stuff, comment) unless stuff.user.id == session[:user_id]
  end
end