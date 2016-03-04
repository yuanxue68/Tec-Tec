class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction
  validates_presence_of :content, :auction, :user
end
