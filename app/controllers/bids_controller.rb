class BidsController < ApplicationController
  before_action :authenticate_user!

  def new
    @auction = Auction.find(params[:auction_id])
    @last_bid = @auction.bids.last
    @bid = @auction.bids.build
  end

  def create
    @auction = Auction.find(params[:auction_id])
    @bid = @auction.place_bid(current_user, bid_params[:bid_amount]) 
    if(@auction.save)
      flash[:success] = "Bid successfully placed"
      redirect_to @auction
    else
      render "new"
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:bid_amount)
  end
end
