class StuffStatusChangedService
  class << self
    def send_email(stuff)
      StuffMailer.with(stuff: stuff).set_status.deliver_later
    end
  end
end