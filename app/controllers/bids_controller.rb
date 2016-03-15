class BidsController < ApplicationController
  before_action :authenticate_user!

  def new
    @auction = Auction.find(params[:auction_id])
    @last_bid = @auction.bids.last
    @bid = @auction.bids.build
  end

  def create
    @auction = Auction.find(params[:auction_id])
    @old_winner = @auction.latest_bid && @auction.latest_bid.user
    @bid = @auction.place_bid(current_user, bid_params[:bid_amount]) 
    if(@auction.save)
      create_notification @auction, @old_winner
      flash[:success] = "Bid successfully placed"
      redirect_to history_auction_path @auction
    else
      render "new"
    end
  end

  private
  def create_notification(auction, old_winner)
    if auction.owner != current_user
      Notification.notify_new_bid(auction)
    end

    if old_winner && old_winner != current_user
      Notification.notify_higher_bid(auction, old_winner)
    end
  end

  def bid_params
    params.require(:bid).permit(:bid_amount)
  end
end
