class Auction < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :bids, dependent: :destroy
  has_many :comments, dependent: :destroy  
  has_many :notifications, dependent: :destroy

  validates_presence_of :owner, :name, :start_time, :end_time
  validate :picture_size, :end_time_in_future
  mount_uploader :picture, AuctionUploader

  scope :order_by_ending, ->{order(:end_time)}
  scope :order_by_created_at, ->{order(created_at: :desc)}  
  scope :order_by_buyout_price, ->{order(:buyout_price)}
  
  def self.active
    where("end_time > ? And brought_out = 'f'", Time.now)
  end
 
  def self.expired
    where("end_time < ? OR brought_out = 't'", Time.now)
  end 

  def self.search_by_name(name)
    if(name && !name.empty?)
      where("name like ?", "%#{name}%")     
    else 
      all
    end
  end

  def self.ordered_search(order, search)
    case 
    when order == "ending" 
      active.search_by_name(search).order_by_ending.includes(:owner)
    when order == "buyout_price"
      active.search_by_name(search).order_by_buyout_price.includes(:owner)
    else
      active.search_by_name(search).order_by_created_at.includes(:owner)  
    end
  end

  def expired?
    self.end_time < Time.now or self.brought_out == 't'
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

  def end_time_in_future
    if(!end_time||end_time <= Time.now)
      errors.add(:end_time, "can not be in the past")
    end
  end

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end
