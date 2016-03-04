require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @auction = @auction || FactoryGirl.build(:auction)
    @user = @user || FactoryGirl.build(:user)
  end

  it "should be able to save" do
    @auction.comments.build(user: @user, content: "hey")
    expect(@auction.comments.last).to be_valid
  end

  it "should not be valid if there is no content" do
    @auction.comments.build(user: @user)
    expect(@auction.comments.last).to_not be_valid
  end
end
