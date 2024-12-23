class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id # Kullanıcıyı oturum açmış gibi kaydet
      redirect_to root_path, notice: "Kayıt başarılı! Hoş geldiniz, #{@user.username}!" # Chatroom'a yönlendirme
    else
      flash.now[:error] = "Kayıt sırasında bir hata oluştu. Lütfen bilgilerinizi kontrol edin."
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # Kullanıcı bilgileri @user değişkeninde bulunacak
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id]) # URL'deki :id parametresine göre kullanıcıyı bul
  end
end