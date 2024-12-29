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
      @community_groups = @user.community_groups
    else
      @user = current_user
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
