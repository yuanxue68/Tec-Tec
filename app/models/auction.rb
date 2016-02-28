class Auction < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
  validates_presence_of :owner, :name, :start_time, :end_time
end
