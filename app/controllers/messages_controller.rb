class MessagesController < ApplicationController
  before_action :require_user
  before_action :set_community_group 

  def create
    @message = @community_group.messages.build(message_params)
    @message.user = current_user

    if @message.save
      ActionCable.server.broadcast "chatroom_channel_#{@community_group.id}", render_message(@message)
      redirect_to community_group_path(@community_group), notice: "Message sent successfully."
    else
      redirect_to community_group_path(@community_group), alert: "Failed to send message."
    end
  end

  private

  def set_community_group
    @community_group = CommunityGroup.find(params[:community_group_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end

  def render_message(message)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message }
    )
  end
end
#değişti 1