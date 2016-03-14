class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @user.notifications.update_all(read: true)
    @notifications = @user.notifications.order(created_at: :desc).includes(:notified_by, :auction).paginate(page: params[:page]).per_page(20) 
    respond_to do |format|
      format.html
      format.js
    end
  end
end
