class EndtimeWork
  include Sidekiq::worker

  def perform(auction_id)
  end
end

