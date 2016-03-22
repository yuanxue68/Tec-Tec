class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:history]  

  def show
    @user = User.find(params[:id])
    @auctions = @user.active_auctions.paginate(page: params[:auction_page], per_page:3)
    if current_user && current_user.id.to_s == params[:id]
      @bids = @user.active_bids.includes(:auction).paginate(page: params[:bid_page], per_page:5)
    end
  end

  def history
    @user = User.find(params[:id])
    @my_old_auctions = current_user.auctions.expired.paginate(page: params[:old_auctions_page], per_page:10)
    @auctions_won = @user.auctions_won.paginate(page: params[:auctions_won_page], per_page: 5)
  end
end
