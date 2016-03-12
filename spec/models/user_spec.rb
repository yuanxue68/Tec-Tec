require 'rails_helper'
require 'byebug'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  it "should return the highest bid the user has on each auction" do
    auction = FactoryGirl.create(:auction)
    buyer = FactoryGirl.create(:user, email:"test2@gmail.com")
    bid1 = FactoryGirl.build(:bid, user: buyer, auction:auction)
    bid2 = FactoryGirl.build(:bid, user: buyer, auction:auction, bid_amount: bid1.bid_amount+5)
    auction.bids << [bid1, bid2]
    auction.save
    expect(buyer.active_bids.first.bid_amount).to be == bid2.bid_amount
  end

  it "should return non expired auctions the user has listed" do
    owner = FactoryGirl.create(:user)
    active_auction = FactoryGirl.create(:auction, owner: owner, end_time: Time.now+5000)
    expired_auction = FactoryGirl.create(:auction, owner: owner, end_time: Time.now-5000)
    expect(owner.active_auctions.first).to be == active_auction

  end

  it "should return the the user has won" do
    seller = FactoryGirl.create(:user, email:"seller@gmail.com")
    buyer = FactoryGirl.create(:user)
    auction_won = FactoryGirl.create(:auction, owner:seller)
    auction_lost = FactoryGirl.create(:auction, owner:seller)
    bid = FactoryGirl.create(:bid, user:buyer, auction:auction_won)
    auction_won.end_time = Time.now - 1
    auction_lost.end_time = Time.now - 1
    auction_won.save
    auction_lost.save
    expect(buyer.auctions_won.first).to be ==  auction_won
  end

end
