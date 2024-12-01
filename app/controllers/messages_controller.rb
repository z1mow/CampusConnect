class MessagesController < ApplicationController
    #before_action :require_user
  
    def create
      user = User.find(1) # login_logout kısmından sonra değişecek
  
      message = user.messages.build(message_params)
  
      if message.save
        ActionCable.server.broadcast "chatroom_channel",
                                      foo: message.body
      end
    end
  
    private
  
    def message_params
      params.require(:message).permit(:body)
    end
  end
  