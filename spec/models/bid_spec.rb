require 'rails_helper'
require 'byebug'

RSpec.describe Bid, type: :model do
  before :each do
    @auction = @auction || FactoryGirl.build(:auction)
    @user = @user || FactoryGirl.build(:user)
  end

  it "should be able to save" do
    @auction.bids.build(user: @user, bid_amount:60.8 )
    expect(@auction.bids.last).to be_valid
  end

  it "should not have an empty bid" do
    @auction.bids.build(user: @user)
    expect(@auction.bids.last).to_not be_valid
  end

  it "should have a bid greater than 0" do
    @auction.bids.build(user: @user, bid_amount: -3.0)
    expect(@auction.bids.last).to_not be_valid
  end
  
  it "should not allow equal bid" do
    newUser = FactoryGirl.build(:user, email: "test2.gmail.com")
    auction = FactoryGirl.create(:auction, owner: newUser)
    auction.bids.create(user: @user, bid_amount: 2)
    auction.bids.build(user: @user, bid_amount: 2)
    expect(auction.bids.last).to_not be_valid
  end
end
