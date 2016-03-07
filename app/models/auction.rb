class Auction < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
  has_many :bids, dependent: :destroy
  has_many :comments, dependent: :destroy  
  validates_presence_of :owner, :name, :start_time, :end_time
  validate :picture_size
  mount_uploader :picture, AuctionUploader

  scope :order_by_ending, ->{order(:end_time)}
  scope :order_by_created_at, ->{order(created_at: :desc)}  
  scope :order_by_buyout_price, ->{order(:buyout_price)}
 
  def self.search_by_name(name)
    if(name && !name.empty?)
      where("name like ?", "%#{name}%")     
    else 
      all
    end
  end

  def self.later_than(time)
    where("end_time > ?", time)
  end
  
  def self.ordered_search(order, search)
    case 
    when order == "ending" 
      later_than(Time.now).search_by_name(search).order_by_ending.includes(:owner)
    when order == "buyout_price"
      later_than(Time.now).search_by_name(search).order_by_buyout_price.includes(:owner)
    else
      later_than(Time.now).search_by_name(search).order_by_created_at.includes(:owner)  
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

  private 

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end
