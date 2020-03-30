class NewStuffRequestedService
  class << self
    def send_email(stuff)
      StuffMailer.with(stuff: stuff).new_request.deliver_later
    end
  end
end