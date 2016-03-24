class Conversation < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  has_many :messages, dependent: :destroy
  validates_presence_of :sender_id, :recipient_id
  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :involving, ->(user) do
    where("(conversations.sender_id = ? OR conversations.recipient_id = ?)", user.id, user.id)
  end

  scope :between, -> (sender_id, recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)  
  end

  def self.latest_conversations(user)
    select("conversations.*, Max(messages.created_at)").involving(user).joins(:messages).group("conversations.id, conversations.sender_id, conversations.recipient_id").order('Max(messages.created_at) desc')
  end
 
end
