require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:giver) }
    it { is_expected.to belong_to(:receiver) }
  end
  
  describe "validations" do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:giver) }
    it { is_expected.to validate_presence_of(:receiver) }

    it "should return invalid for review with more than 400 chracters" do
      giver = FactoryGirl.build(:user)
      receiver = FactoryGirl.create(:user, email:'test2@gmail.com')
      content = "a"*401
      receiver.reviews_received.build(giver: giver, receiver: receiver, content: content)
      expect(receiver.reviews_received.last).to_not be_valid
    end

    it "should return invalid if review receiver and giver are the same user" do
      user = FactoryGirl.create(:user)
      user.reviews_received.build(giver:user, receiver: user, content: "a")
      expect(user.reviews_received.last).to_not be_valid
    end
  end
end
