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
    @user = if params[:id] == "search"
      nil
    elsif params[:id].present?
      User.find(params[:id])
    else
      current_user
    end

    if @user
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
      
      @community_groups = @user.community_groups.includes(:users)
      if @user != current_user
        @is_friend = current_user.friends_with?(@user)
        @can_send_request = current_user.can_send_friend_request?(@user)
        @pending_request = Friend.find_by(user: current_user, friend: @user, status: 'pending') ||
                          Friend.find_by(user: @user, friend: current_user, status: 'pending')
      end
    else
      redirect_to search_users_path(q: params[:q])
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
    Rails.logger.info "Search params: #{params.inspect}"
    
    if params[:q].present?
      search_term = "%#{params[:q].strip}%"
      @users = User.where("username ILIKE ? OR name ILIKE ? OR email ILIKE ?", 
                         search_term, search_term, search_term)
      Rails.logger.info "Found #{@users.count} users matching '#{params[:q]}'"
    else
      @users = []
      Rails.logger.info "No search term provided"
    end

    respond_to do |format|
      format.html { render 'search' }
      format.json { render json: @users }
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

  def chat
    @user = User.find(params[:id])
    Rails.logger.info "Chat action: User found - #{@user.id}"
    
    if current_user.friends_with?(@user)
      Rails.logger.info "Chat action: Users are friends, redirecting to conversation"
      redirect_to conversation_private_messages_path(user_id: @user.id)
    else
      Rails.logger.info "Chat action: Users are not friends"
      flash[:error] = "Sadece arkadaşlarınızla mesajlaşabilirsiniz"
      redirect_to @user
    end
  rescue => e
    Rails.logger.error "Chat action error: #{e.message}"
    flash[:error] = "Bir hata oluştu"
    redirect_to root_path
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
