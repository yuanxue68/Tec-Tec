class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @auction = Auction.find(params[:auction_id])
    @auction.comments.build(
      content: comment_params[:content], user: current_user, auction: @auction
    )
    @auction.save
    respond_to do |format|
      format.html {redirect_to @auction}
      format.js
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

    def correct_user
      @comment = current_user.comments.find(params[:id])
      redirect_to root_path if @comment.nil?
    end
end
