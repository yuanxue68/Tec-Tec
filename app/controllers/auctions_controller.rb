class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  
  def index
    @auctions = Auction.ordered_search(params[:order], params[:search])
      .paginate(page: params[:page]).per_page(15)
  end
  
  def create
    @auction = current_user.auctions.build(auction_params)
    if(@auction.save)
      AuctionEndWorker.perform_at(@auction.end_time, @auction.id)
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
    @bids = @auction.latest_bids.includes(:user).paginate(page: params[:page]).per_page(25)
    render layout: "auction_layout"
  end

  def comments
    @auction = Auction.find(params[:id])
    @comments = @auction.comments.order(created_at: :desc).includes(:user).paginate(page: params[:page]).per_page(25)
    render layout: "auction_layout"
  end
  
  private 
  
  def auction_params
    params[:auction][:start_time] = Time.now
    params.require(:auction).permit(:name, :description, :course_code, :school, :starting_price, :buyout_price, :start_time, :end_time, :picture)
  end
end

