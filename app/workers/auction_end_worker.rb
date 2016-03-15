class AuctionEndWorker
  include Sidekiq::Worker

  def perform(auction_id)
    auction = Auction.find(auction_id)
    Notification.notify_winning_auction(auction) 
  end
end

