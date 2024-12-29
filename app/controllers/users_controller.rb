class UsersController < ApplicationController
  before_action :require_user, only: [:show, :edit, :update, :account, :send_friend_request, :accept_friend_request, :reject_friend_request, :remove_friend]
  before_action :set_user, only: [:send_friend_request, :accept_friend_request, :reject_friend_request, :remove_friend]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Kayıt başarılı! Hoş geldiniz, #{@user.username}!"
    else
      flash.now[:error] = "Kayıt sırasında bir hata oluştu. Lütfen bilgilerinizi kontrol edin."
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if params[:id].present?
      @user = User.find(params[:id])
      cache_key = "user_profile/#{@user.id}-#{@user.updated_at.to_i}"
      Rails.logger.info "Attempting to fetch profile data for user #{@user.id} from cache"
      
      @profile_data = Rails.cache.fetch(cache_key) do
        Rails.logger.info "Cache MISS for user #{@user.id} - generating profile data"
        {
          name: @user.name,
          username: @user.username,
          profile_picture_attached: @user.profile_picture.attached?
        }
      end
      Rails.logger.info "Cache HIT - Retrieved profile data for user #{@user.id} from cache" unless @profile_data.nil?
      @community_groups = @user.community_groups.includes(:users)
      @is_friend = current_user.friends_with?(@user)
      @can_send_request = current_user.can_send_friend_request?(@user)
      @pending_request = Friend.find_by(user: current_user, friend: @user, status: 'pending') ||
                        Friend.find_by(user: @user, friend: current_user, status: 'pending')
    else
      @user = current_user
      cache_key = "user_profile/#{current_user.id}-#{current_user.updated_at.to_i}"
      Rails.logger.info "Attempting to fetch profile data for current_user #{current_user.id} from cache"
      
      @profile_data = Rails.cache.fetch(cache_key) do
        Rails.logger.info "Cache MISS for current_user #{current_user.id} - generating profile data"
        {
          name: current_user.name,
          username: current_user.username,
          profile_picture_attached: current_user.profile_picture.attached?
        }
      end
      Rails.logger.info "Cache HIT - Retrieved profile data for current_user #{current_user.id} from cache" unless @profile_data.nil?
      @community_groups = current_user.community_groups.includes(:users)
    end
  end

  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Profil başarıyla güncellendi."
      redirect_to profile_path
    else
      flash.now[:error] = "Profil güncellenirken bir hata oluştu."
      render :edit, status: :unprocessable_entity
    end
  end

  def account
    @user = current_user
  end

  def search
    if params[:query].present?
      @users = User.where("name LIKE ?", "%#{params[:query]}%")
    else
      @users = []
    end
  end

  def send_friend_request
    if current_user.can_send_friend_request?(@user)
      @friend_request = Friend.new(user: current_user, friend: @user, status: 'pending')
      
      if @friend_request.save
        flash[:notice] = "Arkadaşlık isteği gönderildi"
      else
        flash[:error] = "Arkadaşlık isteği gönderilemedi: #{@friend_request.errors.full_messages.join(', ')}"
      end
    else
      flash[:error] = "Arkadaşlık isteği gönderilemez"
    end
    
    redirect_back(fallback_location: root_path)
  end

  def accept_friend_request
    @friend_request = Friend.find_by(user: @user, friend: current_user, status: 'pending')
    
    if @friend_request
      if @friend_request.update(status: 'accepted')
        flash[:notice] = "Arkadaşlık isteği kabul edildi"
      else
        flash[:error] = "Arkadaşlık isteği kabul edilemedi"
      end
    else
      flash[:error] = "Arkadaşlık isteği bulunamadı"
    end
    
    redirect_back(fallback_location: root_path)
  end

  def reject_friend_request
    @friend_request = Friend.find_by(user: @user, friend: current_user, status: 'pending')
    
    if @friend_request
      if @friend_request.update(status: 'rejected')
        flash[:notice] = "Arkadaşlık isteği reddedildi"
      else
        flash[:error] = "Arkadaşlık isteği reddedilemedi"
      end
    else
      flash[:error] = "Arkadaşlık isteği bulunamadı"
    end
    
    redirect_back(fallback_location: root_path)
  end

  def remove_friend
    @friendship = Friend.where(status: 'accepted')
                       .where('(user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)', 
                              current_user.id, @user.id, @user.id, current_user.id)
                       .first
    
    if @friendship&.destroy
      flash[:notice] = "Arkadaşlıktan çıkarıldı"
    else
      flash[:error] = "Arkadaşlıktan çıkarılamadı"
    end
    
    redirect_back(fallback_location: root_path)
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :profile_picture,:department,:title,:student_class )
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Kullanıcı bulunamadı"
    redirect_to root_path
  end
end
