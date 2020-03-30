class SameStuffCommentedService
  def send_email(stuff, recipients, comment)
    CommentMailer.with(stuff: stuff, recipients: recipients, content: comment).same_stuff_commented.deliver_later
  end
end