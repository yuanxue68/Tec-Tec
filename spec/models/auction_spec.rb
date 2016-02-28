require 'rails_helper'
require 'spec_helper'

RSpec.describe Auction, type: :model do
  it "has a valid factory" do
    auction = FactoryGirl.create(:auction)
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
end
