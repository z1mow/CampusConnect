class GroupMembersController < ApplicationController
  before_action :require_user
  before_action :set_community_group
  before_action :require_creator, only: [:destroy]

  def destroy
    @member = User.find(params[:id])
    if @member != @community_group.creator
      @community_group.users.delete(@member)
      flash[:notice] = "#{@member.username} gruptan çıkarıldı."
    else
      flash[:alert] = "Grup kurucusu gruptan çıkarılamaz."
    end
    redirect_to @community_group
  end

  private

  def set_community_group
    @community_group = CommunityGroup.find(params[:community_group_id])
  end

  def require_creator
    unless current_user == @community_group.creator
      flash[:alert] = "Bu işlem için yetkiniz yok."
      redirect_to @community_group
    end
  end
end
  