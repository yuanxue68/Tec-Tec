require 'rails_helper'
require 'spec_helper'
require 'byebug'

RSpec.describe Auction, type: :model do
  before :all do
    user1 = FactoryGirl.build(:user, email: "test2.gmail.com")
    user2 = FactoryGirl.build(:user, email: "test3.gmail.com")
    @auction_one = FactoryGirl.create(:auction, name: "auction one",
                                      owner: user1, end_time: Time.now+2000 )
    @auction_two = FactoryGirl.create(:auction, name: "auction two",
                                      owner: user2, end_time: Time.now+3000)
  end

  it "has a valid factory" do
    auction = FactoryGirl.build(:auction)
    expect(auction).to be_valid
  end

  it "should have a owner" do
    auction = FactoryGirl.build(:auction, owner_id:nil)
    expect(auction).to_not be_valid
  end

  it "should have a name" do
    auction = FactoryGirl.build(:auction, name:nil)
    expect(auction).to_not be_valid
  end

  it "should have a start time" do
    auction = FactoryGirl.build(:auction, start_time:nil)
    expect(auction).to_not be_valid
  end

  it "should have a end time" do
    auction = FactoryGirl.build(:auction, end_time:nil)
    expect(auction).to_not be_valid
  end
  
  it "should be ordered by end time" do
    expect(Auction.order_by_created_at).to be == [@auction_two, @auction_one] 
  end

  it "should be ordered by created at" do
    expect(Auction.order_by_ending).to be == [@auction_one, @auction_two]
  end

  it "should filter based on search value" do
    expect(Auction.ordered_search(nil, "one")).to be == [@auction_one]
  end

  it "should be able to filter with empty string" do
    expect(Auction.ordered_search("ending","")).to be == [@auction_one, @auction_two]
  end
end
