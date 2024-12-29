class CommunityGroupsController < ApplicationController
    before_action :require_user
    before_action :set_community_group, only: [:show, :edit, :update, :destroy] 

    def index
      @community_groups = CommunityGroup.all
      @user_chatrooms = current_user.community_groups || []
      @available_chatrooms = CommunityGroup.where.not(id: @user_chatrooms.pluck(:id)) || []
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
        redirect_to @community_group, alert: "Zaten bu grubun üyesisiniz."
      else
        @community_group.users << current_user
        redirect_to @community_group, notice: "Gruba başarıyla katıldınız!"
      end
    end
  
    def leave
      @community_group = CommunityGroup.find(params[:id])
      
      if current_user == @community_group.creator
        redirect_to @community_group, alert: "Grup kurucusu gruptan ayrılamaz."
      elsif current_user.member_of?(@community_group)
        @community_group.users.delete(current_user)
        redirect_to community_groups_path, notice: "Gruptan başarıyla ayrıldınız."
      else
        redirect_to @community_group, alert: "Bu grubun üyesi değilsiniz."
      end
    end
  
    def destroy
      @community_group = CommunityGroup.find(params[:id])
      
      if current_user == @community_group.creator
        if @community_group.destroy
          flash[:notice] = "Grup başarıyla silindi."
          redirect_to community_groups_path
        else
          flash[:alert] = "Grup silinirken bir hata oluştu."
          redirect_to community_group_path(@community_group)
        end
      else
        flash[:alert] = "Bu işlem için yetkiniz yok."
        redirect_to community_group_path(@community_group)
      end
    end
  
    def edit
      unless current_user == @community_group.creator
        flash[:alert] = "Bu işlem için yetkiniz yok."
        redirect_to @community_group
      end
    end
  
    def update
      if current_user == @community_group.creator
        if @community_group.update(community_group_params)
          respond_to do |format|
            format.html { 
              flash[:notice] = "Grup başarıyla güncellendi."
              redirect_to @community_group
            }
            format.json { 
              render json: {
                status: :ok,
                description: @community_group.description
              }
            }
          end
        else
          respond_to do |format|
            format.html {
              flash[:alert] = @community_group.errors.full_messages.join(", ")
              render :edit, status: :unprocessable_entity
            }
            format.json {
              render json: {
                status: :error,
                errors: @community_group.errors.full_messages
              }, status: :unprocessable_entity
            }
          end
        end
      else
        flash[:alert] = "Bu işlem için yetkiniz yok."
        redirect_to @community_group
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
  