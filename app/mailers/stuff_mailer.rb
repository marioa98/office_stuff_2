class StuffMailer < ApplicationMailer  
  
  default to: -> {User.where(admin: true).pluck(:email)}

  def set_status
    @stuff = params[:stuff]
    email = @stuff.user.email
    @url = "http://localhost:3000/details/#{@stuff.id}"
    mail(to: email, subject: "Status change in '#{@stuff.stuff_name}'")
  end

  def new_request
    @stuff = params[:stuff]
    @url = "http://localhost:3000/details/#{@stuff.id}"

    mail(subject: "New stuff request")
  end
end