class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @auction = Auction.find(params[:auction_id])
    @auction.comments.build(
      content: comment_params[:content], user: current_user, auction: @auction
    )
    if @auction.save
      create_notification @auction 
      respond_to do |format|
        format.html {redirect_to comments_auction_path @auction}
        format.js
      end
    else
      flash[:failure] = "an error has occured while saving the comment"
      redirect_to comments_auction_path(@auction)
    end
  end

  def destroy
    @comment.destroy
    render json: {id: params[:id]}
  end
  
  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def create_notification(auction)
      return if auction.owner == current_user
      Notification.create(user: auction.owner,
                          notified_by: current_user,
                          auction: auction,
                          notice_type: "new comment")
    end

    def correct_user
      @comment = current_user.comments.find(params[:id])
      redirect_to root_path if @comment.nil?
    end
end
