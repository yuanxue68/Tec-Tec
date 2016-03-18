require 'rails_helper'
require 'byebug'

RSpec.describe BidsController, type: :controller do
  before :each do   
    @auction = FactoryGirl.create(:auction)
    @user = double('user')
  end
  
  describe "GET #new" do
    it "returns http success" do
      allow(request.env['warden']).to receive(:authenticate!).and_return(@user)
      allow(controller).to receive(:current_user).and_return(@user) 
      allow(Auction).to receive(:find).and_return(@auction)
      controller.params[:auction_id] = @auction.id
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http redirect on success bid" do
      allow(request.env['warden']).to receive(:authenticate!).and_return(@user)
      allow(controller).to receive(:bid_params).and_return({bid_amount:3})
      allow(controller).to receive(:current_user).and_return(@user) 
      allow(controller).to receive(:create_notification).and_return(true)
      allow(Auction).to receive(:find).and_return(@auction) 
      allow(@auction).to receive(:place_bid).and_return(true)
      allow(@auction).to receive(:save).and_return(true)
      get :create
      expect(flash[:success]).to eq("Bid successfully placed")
      expect(response).to have_http_status(:redirect)
    end
    
    it "returns New template on error" do
      allow(request.env['warden']).to receive(:authenticate!).and_return(@user)
      allow(controller).to receive(:bid_params).and_return({bid_amount:3})
      allow(controller).to receive(:current_user).and_return(@user) 
      allow(Auction).to receive(:find).and_return(@auction) 
      allow(@auction).to receive(:place_bid).and_return(true)
      allow(@auction).to receive(:save).and_return(false)
      get :create
      expect(response).to render_template("new")
    end
  end

end
