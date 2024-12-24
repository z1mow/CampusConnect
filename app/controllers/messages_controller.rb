class MessagesController < ApplicationController
    #before_action :require_user
  
    def create
      user = User.find(9) # login_logout kısmından sonra değişecek
  
      message = user.messages.build(message_params)
  
      if message.save
        redirect_to root_path
      else
        render :new 
      end
    end
  
    private
  
    def message_params
      params.require(:message).permit(:body)
    end
  end
  