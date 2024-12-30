class MessagesController < ApplicationController
  before_action :require_user
  before_action :set_community_group 

  def create
    # Transaction ve izolasyon seviyesi ekleniyor
    ActiveRecord::Base.transaction(isolation: :read_committed) do
      @message = @community_group.messages.build(message_params)
      @message.user = current_user

      if @message.save
        broadcast_message

        respond_to do |format|
          format.html { redirect_to community_group_chatroom_path(@community_group) }
          format.json { render json: { success: true } }
        end
      else
        raise ActiveRecord::Rollback # Hata durumunda tüm işlemleri geri al
        respond_to do |format|
          format.html { redirect_to community_group_chatroom_path(@community_group), alert: "Mesaj gönderilemedi." }
          format.json { render json: { success: false }, status: :unprocessable_entity }
        end
      end
    end
  rescue ActiveRecord::Rollback
    respond_to do |format|
      format.html { redirect_to community_group_chatroom_path(@community_group), alert: "Mesaj gönderilemedi." }
      format.json { render json: { success: false }, status: :unprocessable_entity }
    end
  end

  private

  def broadcast_message
    html_content = ApplicationController.renderer.render(
      partial: 'messages/message',
      locals: { message: @message }
    )

    ActionCable.server.broadcast(
      "chatroom_channel_#{@community_group.id}",
      {
        html: html_content,
        sender_id: @message.user_id
      }
    )
  end

  def set_community_group
    @community_group = CommunityGroup.find(params[:community_group_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
