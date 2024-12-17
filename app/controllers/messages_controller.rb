class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id]) # chatroom_id'yi al
    @message = @chatroom.messages.new(message_params) # Yeni mesaj oluştur
    if @message.save
      redirect_to chatroom_path(@chatroom) # Başarılıysa chatroom sayfasına dön
    else
      flash[:error] = "Message could not be sent"
      redirect_to chatroom_path(@chatroom) # Hata mesajı göster
    end
  end

  private

  def message_params
    params.require(:message).permit(:content) # Sadece content parametresine izin ver
  end
end


  