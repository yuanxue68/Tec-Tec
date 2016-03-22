class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :expired_auction, only: [:new, :create]

  def new
    @auction = Auction.find(params[:auction_id])
    @last_bid = @auction.bids.last
    @bid = @auction.bids.build
   end

  def create
    @old_winner = @auction.latest_bid && @auction.latest_bid.user
    @bid = @auction.place_bid(current_user, bid_params[:bid_amount]) 
    if(@auction.buyout_price && bid_params[:bid_amount].to_f >= @auction.buyout_price)
      @auction.brought_out = true
    end
    if(@auction.save)
      create_notification @auction, @old_winner
      flash[:success] = "Bid successfully placed"
      redirect_to history_auction_path @auction
    else
      render "new"
    end
  end

  private
  def expired_auction
    @auction = Auction.find(params[:auction_id])
    if @auction.expired? 
      flash[:danger] = "Auction has already expired"
      redirect_to auction_path(@auction)
    end
  end

  def create_notification(auction, old_winner)
    if auction.owner != current_user
      Notification.notify_new_bid(auction, current_user)
    end

    if old_winner && old_winner != current_user
      Notification.notify_higher_bid(auction, old_winner, current_user)
    end
  end

  def bid_params
    params.require(:bid).permit(:bid_amount)
  end
end
