require 'rails_helper'
require 'byebug'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:auction) { create(:auction) }
  describe 'associations' do
    it { is_expected.to have_many :bids }
    it { is_expected.to have_many :comments }
    it { is_expected.to have_many :reviews_written }
    it { is_expected.to have_many :reviews_received }
    it { is_expected.to have_many :notifications }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :display_name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
  end

  describe "bids" do
    let!(:auction) {create(:auction)}
    it "should return the highest bid the user has on each auction" do
      bid1 = FactoryGirl.build(:bid, user: user, auction:auction)
      bid2 = FactoryGirl.build(:bid, user: user, auction:auction, bid_amount: bid1.bid_amount+5)
      auction.bids << [bid1, bid2]
      auction.save
      expect(user.active_bids.first.bid_amount).to be == bid2.bid_amount
    end
  end
  
  describe "auctions" do
    it "should return non expired auctions the user has listed" do
      active_auction = FactoryGirl.create(:auction, owner: user, end_time: Time.now+5000)
      expired_auction = FactoryGirl.build(:auction, owner: user, end_time: Time.now-5000)
      expired_auction.save(validate: false)
      expect(user.active_auctions.first).to be == active_auction

    end

    it "should return auctions the user has won" do
      seller = FactoryGirl.create(:user, email:"seller@gmail.com")
      buyer = FactoryGirl.create(:user)
      auction_won = FactoryGirl.create(:auction, owner:seller)
      auction_lost = FactoryGirl.create(:auction, owner:seller)
      bid = FactoryGirl.create(:bid, user:buyer, auction:auction_won)
      auction_won.end_time = Time.now - 1
      auction_lost.end_time = Time.now - 1
      auction_won.save(validate: false)
      auction_lost.save(validate: false)
      expect(buyer.auctions_won.first).to be ==  auction_won
    end
  end

  describe "conversations" do
    let!(:user) {create(:user)}
    let!(:conversation1) { create(:conversation, sender: user) }
    let!(:conversation2) { create(:conversation) }
    it "should return conversations the user belongs to" do
      expect(user.conversations.first).to be == conversation1 
    end

    it "check wether the use is part of the conversation" do
      expect(user.is_part_of_convo(conversation2.id)).to be false
    end
  end

  describe "messages" do
    let!(:sender) { create(:user) }
    let!(:recipient) { create(:user) }
    let!(:conversation) { create(:conversation, sender: sender, recipient: recipient) }
    it "should have the correct unread message count" do
      FactoryGirl.create(:message, conversation: conversation, user: sender)
      expect(recipient.unread_message_count).to be 1
    end

    it "should read all messages" do
      FactoryGirl.create(:message, conversation: conversation, user: sender) 
      recipient.read_all_messages 
      expect(recipient.unread_message_count).to be 0
    end
  end

  describe "notifications" do
    let!(:user) { create(:user) }
    it "should have the correct notification count" do
      FactoryGirl.create(:notification, user: user) 
      expect(user.unread_notification_count).to be 1
    end
  end
end
