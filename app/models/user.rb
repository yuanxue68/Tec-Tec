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
  has_many :auctions_won, class_name: 'Auction', foreign_key: 'winner_id' 
  has_many :bids, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
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

  def active_auctions
    auctions.later_than(Time.now)
  end

  def active_bids
    bids.where('(bids.auction_id, bids.bid_amount) in (select auctions.id, max(bids.bid_amount) from bids, auctions where bids.auction_id = auctions.id group by auctions.id)')
    .order(created_at: :desc)
  end  
  private

  
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
