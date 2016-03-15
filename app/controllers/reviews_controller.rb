class ReviewsController < ApplicationController 
  before_action :authenticate_user!, only: [:create, :destroy]
  
  def index
    @user = User.find(params[:user_id])
    @reviews = @user.reviews_received.order(created_at: :desc).includes(:giver).paginate(page:params[:page]).per_page(15)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @user = User.find(params[:user_id])
    @user.reviews_received.build(
      content: params[:review][:content], 
      giver: current_user,
      receiver: @user
    )
    if @user.save
      Notification.notify_new_review(@user, current_user)
      respond_to do |format|
        format.html {redirect_to user_reviews_path(@user)}
        format.js
      end
    else 
      flash[:failure] = "an error has occured while saving review"
      redirect_to user_reviews_path @user
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    render json: {id: params[:id]}
  end

  private
  
end
