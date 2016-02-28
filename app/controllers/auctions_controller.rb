class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  
  def index
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
  end

  def destroy
  end

  private 
  
  def auction_params
    params.require(:auction).permit(:name, :description, :course_code, :school, :starting_price, :buyout_price, :start_time, :end_time)
  end
end

