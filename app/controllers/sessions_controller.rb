class SessionsController < ApplicationController
  def new
    # Login formunu göstermek için
  end

  def create
    # Kullanıcıyı email üzerinden bul
    user = User.find_by(email: params[:email])

    # Kullanıcı varsa ve şifre doğruysa giriş yap
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id # Kullanıcı oturumunu başlat
      redirect_to root_path, notice: "Giriş başarılı!" # Chatroom sayfasına yönlendirme
    else
      flash.now[:alert] = "Geçersiz email veya şifre"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # Kullanıcı oturumunu sonlandır
    session[:user_id] = nil
    redirect_to login_path, notice: "Çıkış başarılı!"
  end
end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to login_path
  end

