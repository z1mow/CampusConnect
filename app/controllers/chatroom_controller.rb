class ChatroomController < ApplicationController
    before_action :require_user
    before_action :set_community_group
  
    def index
      @message = Message.new
      @messages = @community_group.messages.includes(:user) # Sadece bu grubun mesajları
    end
  
    private
  
    def set_community_group
        if params[:community_group_id].present?
          @community_group = CommunityGroup.find_by(id: params[:community_group_id])
          unless @community_group
            flash[:alert] = "Community group not found."
            redirect_to community_groups_path
          end
        else
          flash[:alert] = "No community group ID provided."
          redirect_to community_groups_path
        end
      end
    end
  