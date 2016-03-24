require 'rails_helper'
require 'spec_helper'
require 'byebug'

RSpec.describe Auction, type: :model do
  let!(:auction) {create(:auction)}

  describe 'associations' do
    it { is_expected.to have_many :bids}
    it { is_expected.to have_many :comments}
    it { is_expected.to have_many :notifications}
    it { is_expected.to belong_to :owner}
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :owner }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :start_time }
    it { is_expected.to validate_presence_of :end_time }
  end

  describe "scopes" do
    let!(:auction_two) {create(:auction, 
        end_time: auction.end_time + 1, buyout_price: auction.buyout_price + 1)}

    it "should be ordered by end time" do
      expect(Auction.order_by_created_at).to be == [auction_two, auction] 
    end

    it "should be ordered by created at" do
      expect(Auction.order_by_ending).to be == [auction, auction_two]
    end

    it "should be ordered by buy out price" do
      expect(Auction.order_by_buyout_price).to be == [auction, auction_two]
    end
  end

  describe "search" do
    let!(:auction_two) {create(:auction, name: "two")}
    it "should filter based on search value" do
      expect(Auction.ordered_search(nil, "two")).to be == [auction_two]
    end

    it "should be able to filter with empty string" do
      expect(Auction.ordered_search("ending","")).to be == [auction, auction_two]
    end
    
    it "should be able to search auction by name" do
      expect(Auction.search_by_name("two").first).to be == auction_two
    end

    it "should be return all auction is there is no search specified" do
      expect(Auction.search_by_name(nil).count).to be == 2
    end

  end
  
  describe "custom model functions" do
    it "shoulde return auction that has expired" do
      expired_auction = FactoryGirl.build(:auction, end_time: Time.now-1)
      expired_auction.save(validate: false)
      expect(Auction.expired.first).to be == expired_auction
    end

    it "should not be valid if end time is in the past" do
      auction = FactoryGirl.build(:auction, end_time: Time.now-1)
      expect(auction).to_not be_valid
    end

    it "should not be valid if more than 2 weeks past start time" do
      auction = FactoryGirl.build(:auction, end_time: Time.now + 3.weeks.to_i)
      expect(auction).to_not be_valid
    end
  end
end
