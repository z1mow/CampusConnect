class NotificationsController < ApplicationController
  before_action :require_user
  
  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page]).per(20)
    current_user.mark_notifications_as_read!
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.mark_as_read!
    
    respond_to do |format|
      format.html { redirect_back(fallback_location: notifications_path) }
      format.json { render json: { success: true } }
    end
  end

  def mark_all_as_read
    current_user.mark_notifications_as_read!
    
    respond_to do |format|
      format.html { redirect_back(fallback_location: notifications_path) }
      format.json { render json: { success: true } }
    end
  end
end 