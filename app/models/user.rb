class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, :omniauth_providers => [:facebook]
  validates_presence_of :display_name
  validate :picture_size
  mount_uploader :picture, AvatarUploader 

  has_many :auctions, dependent: :destroy, foreign_key: 'owner_id' 
  has_many :bids, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews_written, class_name:'Review', dependent: :destroy, foreign_key: 'giver_id'
  has_many :reviews_received, class_name:'Review', dependent: :destroy, foreign_key: 'receiver_id'
  has_many :notifications, dependent: :destroy

  def conversations
    Conversation.where("sender_id = ? OR recipient_id = ?", self.id, self.id)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.display_name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.confirmed_at = Time.now.getutc
    end
  end
	
	def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  #is there a more rails way??
  def auctions_won
    Auction
    .expired
    .joins(:bids)
    .where("bids.user_id = ?", id)
    .where('(bids.auction_id, bids.bid_amount) in (select auctions.id, max(bids.bid_amount) from auctions, bids where bids.auction_id = auctions.id group by auctions.id )')
  end

  def active_auctions
    auctions.active
  end

  #is there a more rails way??
  def active_bids
    bids.where("(bids.auction_id, bids.bid_amount) in (select auctions.id, max(bids.bid_amount) from bids, auctions where bids.auction_id = auctions.id AND auctions.brought_out = 'f' group by auctions.id)")
    .order(created_at: :desc)
  end  

  def unread_notification_count
    notifications.where(read: false).count
  end

  def unread_message_count
    conversations.joins(:messages)
      .where('messages.read = ? And messages.user_id != ?', false, self.id).count
  end

  def read_all_messages
    Message.joins(:conversation)
      .where("sender_id = ? OR recipient_id = ?", self.id, self.id)
      .where('messages.read = ? And messages.user_id != ?', false, self.id).update_all(read: true)
  end

  def is_part_of_convo(conversation_id)
    conversation_id && conversations.exists?(conversation_id)
  end

  private
  
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
