class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction 
  validates_presence_of :user, :auction, :bid_amount
  validates_numericality_of :bid_amount, greater_than_or_equal:0
  validate :greater_than_last, :not_owner, :auction_not_expired

  private
  def greater_than_last
    return unless auction
    last_bid = auction.latest_bid ? auction.latest_bid.bid_amount : 0
    if bid_amount && (bid_amount <= last_bid || bid_amount < auction.starting_price)
      errors.add(:bid_amount, "should be greater than other bids and starting price")
    end
  end

  def auction_not_expired
    if auction && (auction.end_time < Time.now)
      errors.add(:auction,"can't be expired")
    end
  end

  def not_owner
    if auction && (auction.owner == user)
      errors.add(:user, "can't bid on his own auction")
    end
  end
end
