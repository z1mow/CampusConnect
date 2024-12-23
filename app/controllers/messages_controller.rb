class MessagesController < ApplicationController
  before_action :require_user

  def create
    # Chatroom ilişkilendirmesi
    @chatroom = Chatroom.find(params[:chatroom_id])
    # Yeni mesaj oluşturuluyor
    @message = @chatroom.messages.new(message_params)
    # Mesajın sahibi olarak mevcut kullanıcı atanıyor
    @message.user = current_user

    if @message.save
      # Mesaj kaydedildikten sonra ActionCable ile yayınlanıyor
      ActionCable.server.broadcast "chatroom_channel", render_message(@message)
    else
      flash[:error] = "Mesaj gönderilemedi."
      redirect_to chatroom_path(@chatroom)
    end
  end

  private

  # Güvenli parametreleri tanımlıyoruz
  def message_params
    params.require(:message).permit(:content) # content dışında hiçbir parametreye izin verilmez
  end

  # Mesajın render edilmesi
  def render_message(message)
    ApplicationController.render(
      partial: 'messages/message', # _message.html.erb partial dosyasını kullanır
      locals: { message: message }
    )
  end
end
