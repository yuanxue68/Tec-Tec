class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction 
  validates_presence_of :user, :auction, :bid_amount
  validates :bid_amount, numericality: {greater_than:0}
  validate :greater_than_last

  private
  def greater_than_last
    last_bid = auction.latest_bid ? auction.latest_bid.bid_amount : 0
    if bid_amount && bid_amount <= last_bid
      errors.add(:bid_amount, "should be greater than other bids")
    end
  end
end
