class GroupMembersController < ApplicationController
  before_action :set_community_group
  def create
    unless @community_group.users.include?(current_user)
      @community_group.users << current_user
      flash[:notice] = "You have successfully joined the chatroom!"
    else
      flash[:alert] = "You are already a member of this chatroom."
    end
    redirect_to community_group_path(@community_group)
  end
  
    def destroy
      @community_group = CommunityGroup.find(params[:community_group_id])
      @user = User.find(params[:id]) # Çıkarılacak kullanıcı
      @community_group.users.delete(@user)
  
      redirect_to @community_group, notice: 'User removed from the group.'
    end
  end

  private

  def set_community_group
    @community_group = CommunityGroup.find_by(id: params[:community_group_id])
    unless @community_group
      flash[:alert] = "Community group not found."
      redirect_to community_groups_path
    end
  end
  