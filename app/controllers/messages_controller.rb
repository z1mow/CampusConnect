class MessagesController < ApplicationController
  before_action :require_user

  def create
    message = current_user.messages.build(message_params)
    if message.save
      # Yeni mesajı yayınla
      ActionCable.server.broadcast "chatroom_channel", render_message(message)
    end
    redirect_to root_path
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  # Mesajın HTML formatında render edilmesi
  def render_message(message)
    ApplicationController.render(
      partial: 'messages/message', # _message.html.erb
      locals: { message: message }
    )
  end
end
