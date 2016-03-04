class CommentsController < ApplicationController
  def create
    @auction = Auction.find(params[:auction_id])
    @auction.comments.build(
      content: comment_params[:content], user: current_user, auction: @auction
    )
    if @auction.save
      render json:@auction.comments.last
    else
      render json:@auction.errors, status: 400
    end 
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render json: {id: params[:id]}
  end
  
  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
