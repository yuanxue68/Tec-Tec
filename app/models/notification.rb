class Notification < ActiveRecord::Base
  belongs_to :notified_by, class_name: 'User'
  belongs_to :user
  belongs_to :auction

  validates_presence_of :user, :notice_type 

  def self.notify_winning_auction(auction)
    create(user: auction.latest_bid.user,
          auction: auction,
          notice_type: "winning auction" )
  end

  def self.notify_higher_bid(auction, old_winner)
    create(user:old_winner,
          notified_by: current_user,
          auction: auction,
          notice_type: "bid over")
  end

  def self.notify_new_bid(auction)
    create(user: auction.owner,
          notified_by: current_user,
          auction: auction,
          notice_type: "new bid") 
  end

  def self.notify_new_review(user)
    create(user: user,
          notified_by: current_user,
          notice_type: "new review")
  end

  def self.notify_new_comment(auction)
    create(user: auction.owner,
          notified_by: current_user,
          auction: auction,
          notice_type: "new comment")
  end
end
