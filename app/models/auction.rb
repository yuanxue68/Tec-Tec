class Auction < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
  has_many :bids, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates_presence_of :owner, :name, :start_time, :end_time
  
  scope :order_by_ending, ->{order(:end_time)}
  scope :order_by_created_at, ->{order(created_at: :desc)}  

  def self.ordered_search(order, search)
    if order && !order.empty?
      if search && !search.empty?
        where("name like ?", "%#{search}%").order_by_ending.includes(:owner)
      else
        order_by_ending.includes(:owner)
      end
    else
      if search && !search.empty?
        where("name like ?", "%#{search}%").order_by_created_at.includes(:owner)
      else
        order_by_created_at.includes(:owner)
      end
    end
  end

  def place_bid (bidder, bid_amount)
    bids.build(user: bidder, bid_amount: bid_amount)  
  end
  
  def latest_bids
    bids.order(created_at: :desc)
  end
  
  def latest_bid
    bids.order(:created_at).last
  end
end
