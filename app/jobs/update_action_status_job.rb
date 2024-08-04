class UpdateActionStatusJob < ApplicationJob
  queue_as :default

  def perform
    puts 'Updating actions status...'
    Action.all.each do |action|
      if Time.current < action.start_date
        action.update(status: 'pending')
      elsif Time.current >= action.start_date && Time.current <= action.end_date
        action.update(status: 'active')
      elsif Time.current > action.end_date
        action.update(status: 'completed')
      end
    end
  end
end
