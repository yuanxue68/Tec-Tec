require 'rails_helper'
require 'byebug'

RSpec.describe Bid, type: :model do
  let!(:auction){create(:auction)}
  let!(:user){create(:user)} 

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:auction) } 
  end

  describe "validations" do
    it "should have a bid greater than 0" do
      auction.bids.build(user: user, bid_amount: -3.0)
      expect(auction.bids.last).to_not be_valid
    end
    
    it "should not allow equal bid" do
      auction.bids.create(bid_amount: 2)
      auction.bids.build(bid_amount: 2)
      expect(auction.bids.last).to_not be_valid
    end
  end
end
