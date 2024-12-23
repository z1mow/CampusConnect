class CommunityGroupsController < ApplicationController
    before_action :require_user
    before_action :set_community_group, only: [:show, :edit, :update, :destroy] 
    #ilgili chatroom'u @community_groups değerine kaydeder
  
    def index #tüm chatroomları listeler
      @community_groups = CommunityGroup.all
    end
  
    def show
        if @community_group.users.include?(current_user)
          redirect_to community_group_chatroom_path(@community_group) # Kullanıcı üye ise mesajlaşma sayfasına yönlendir
        else
          @members = @community_group.users
          @messages = @community_group.messages
        end
      end
  
    def new #yeni chatroom için form görüntüler
      @community_group = CommunityGroup.new
    end
  
    def create #formdan gelen verilerle chatroom u oluşturur ve veritabanına kaydeder.
      @community_group = CommunityGroup.new(community_group_params)
      @community_group.creator = current_user
      if @community_group.save
        redirect_to @community_group, notice: 'Chatroom successfully created!' #başarılıysa show'a yönlendirilir.
      else
        flash[:alert] = @community_group.errors.full_messages.join(", ")
        render :new, status: :unprocessable_entity #HTTP durum kodu
      end
    end
    #redirect_to : Yeni bir sayfaya yönlendirir. / render : Aynı sayfayı yeniden işler.
  
    private #sadece bu dosyada tanımlı fonksiyonlar

    def require_user
        unless current_user
          flash[:alert] = "You must be logged in to create a chatroom."
          redirect_to login_path
        end
      end
  
    def set_community_group #istenile chatroom'u işlem yapmadan önce bulur
        @community_group = CommunityGroup.find_by(id: params[:id])
        unless @community_group
          flash[:alert] = "Chatroom not found."
          redirect_to community_groups_path
        end
    end
  
    def community_group_params #sadece verilen alanlarda değişiklik yapılabilmesini sağlar(güvenlik) 
      params.require(:community_group).permit(:name, :is_trend)
    end
  end
  