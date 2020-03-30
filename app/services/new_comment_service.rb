class NewCommentService
  def send_email(stuff, comment)
    CommentMailer.with(stuff: stuff, content: comment).new_comment.deliver_later
  end
end