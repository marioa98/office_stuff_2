class StuffMailer < ApplicationMailer
  def set_status
    @stuff = params[:stuff]
    email = @stuff.user.email
    @url = "http://localhost:3000/details/#{@stuff.id}"
    mail(to: email, subject: "Status change in '#{@stuff.stuff_name}'")
  end
end