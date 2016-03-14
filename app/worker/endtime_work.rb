class EndtimeWork
  include Sidekiq::Worker

  def perform(auction_id)
  end
end

