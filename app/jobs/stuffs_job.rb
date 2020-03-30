class StuffsJob < ApplicationJob
  queue_as :default

  def perform(stuff, stuff_action)
    case stuff_action
    when 'create'
      NewStuffRequestedService.send_email(stuff)
    when 'update'
      StuffStatusChangedService.send_email(stuff)
    end
  end
end