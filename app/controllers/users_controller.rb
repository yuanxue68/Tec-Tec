class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @active_auctions = @user.active_auctions.paginate(page: params[:page], per_page:3)
    if current_user.id.to_s == params[:id]
  		@my_bids = @user.active_bids
		end
  end

end
