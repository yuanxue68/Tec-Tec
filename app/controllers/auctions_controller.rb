class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  
  def index
    @auctions = Auction.paginate(page: params[:page]).per_page(12)
  end

  def create
    @auction = current_user.auctions.build(auction_params)
    if(@auction.save)
      flash[:success] = "Auction Successfully Created"
      redirect_to auctions_path
    else
      render "auctions/new" 
    end
  end

  def new
    @auction = current_user.auctions.build
  end

  def show
    @auction = Auction.find(params[:id])
    render layout: "auction_layout"
  end

  def destroy
  end

  def history
    @auction = Auction.find(params[:id])
    @bids = @auction.latest_bids
    render layout: "auction_layout"
  end

  def comments
    @auction = Auction.find(params[:id])
    render layout: "auction_layout"
  end
  private 
  
  def auction_params
    params.require(:auction).permit(:name, :description, :course_code, :school, :starting_price, :buyout_price, :start_time, :end_time)
  end
end

