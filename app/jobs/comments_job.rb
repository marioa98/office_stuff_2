class CommentsJob < ApplicationJob
  queue_as :default

  def perform(stuff, recipients, comment, commenter_id)
    SameStuffCommentedService.new.send_email(stuff, recipients, comment)
    NewCommentService.new.send_email(stuff, comment) unless stuff.user_id == commenter_id
  end
end