class DirectMessagesController < ApplicationController
  before_action :require_user
  before_action :set_receiver, only: [:conversation, :create]
  before_action :check_friendship, only: [:conversation, :create]

  def conversation
    @messages = current_user.direct_messages_with(@receiver)
    @new_message = DirectMessage.new
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    @message.receiver = User.find(params[:direct_message][:receiver_id])

    if @message.save
      # Broadcast the message through Action Cable
      DirectMessageChannel.broadcast_to(
        @receiver,
        message: render_to_string(partial: 'direct_messages/message', locals: { message: @message })
      )
      
      respond_to do |format|
        format.html { redirect_to conversation_direct_messages_path(@receiver) }
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = "Mesaj gönderilemedi: #{@message.errors.full_messages.join(', ')}"
          redirect_to conversation_direct_messages_path(@receiver)
        end
        format.js { render :create_error }
      end
    end
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Alıcı bulunamadı"
    redirect_to root_path
  end

  private

  def set_receiver
    @receiver = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Kullanıcı bulunamadı"
    redirect_to root_path
  end

  def check_friendship
    unless current_user.friends_with?(@receiver)
      flash[:error] = "Sadece arkadaşlarınızla mesajlaşabilirsiniz"
      redirect_to root_path
    end
  end

  def message_params
    params.require(:direct_message).permit(:content)
  end
end 