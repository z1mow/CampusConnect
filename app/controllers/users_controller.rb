class UsersController < ApplicationController
  before_action :require_user, only: [:show, :edit, :update, :account]

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

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :profile_picture,:department,:title,:student_class )
  end
end
