class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_channel_#{params[:community_group_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
