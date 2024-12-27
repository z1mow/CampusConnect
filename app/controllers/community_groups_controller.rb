class CommunityGroupsController < ApplicationController
    before_action :require_user
    before_action :set_community_group, only: [:show, :edit, :update, :destroy] 

    def index
      @community_groups = CommunityGroup.all
    end
  
    def show
      @members = @community_group.users
      @messages = @community_group.messages
    end
  
    def new
      @community_group = CommunityGroup.new
    end
  
    def create
      @community_group = CommunityGroup.new(community_group_params)
      @community_group.creator = current_user
      if @community_group.save
        redirect_to @community_group, notice: 'Chatroom successfully created!'
      else
        flash[:alert] = @community_group.errors.full_messages.join(", ")
        render :new, status: :unprocessable_entity
      end
    end
  
    def join
      @community_group = CommunityGroup.find(params[:id])
      
      if current_user.member_of?(@community_group)
        redirect_to community_groups_path, alert: "Zaten bu grubun üyesisiniz."
      else
        @community_group.users << current_user
        redirect_to community_group_chatroom_path(@community_group), notice: "Gruba başarıyla katıldınız!"
      end
    end
  
    private

    def require_user
      unless current_user
        flash[:alert] = "You must be logged in to create a chatroom."
        redirect_to login_path
      end
    end
  
    def set_community_group
      @community_group = CommunityGroup.find_by(id: params[:id])
      unless @community_group
        flash[:alert] = "Chatroom not found."
        redirect_to community_groups_path
      end
    end
  
    def community_group_params
      params.require(:community_group).permit(:name, :description, :category)
    end
end
  