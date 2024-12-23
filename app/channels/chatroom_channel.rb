class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_channel_#{params[:community_group_id]}"
  end

  def unsubscribed
    # Bağlantı koptuğunda yapılacak işlemler
  end
end