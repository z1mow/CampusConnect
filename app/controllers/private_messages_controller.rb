class PrivateMessagesController < ApplicationController
  before_action :require_user
  before_action :set_receiver, only: [:conversation, :create]
  before_action :check_friendship, only: [:conversation, :create]

  def conversation
    Rails.logger.info "Conversation action: Started with user_id: #{params[:user_id]}"
    Rails.logger.info "Conversation action: Current user - #{current_user.id}, Receiver - #{@receiver.id}"
    
    @messages = current_user.private_messages_with(@receiver)
    @new_message = PrivateMessage.new
    
    Rails.logger.info "Conversation action: Found #{@messages.count} messages"
  rescue => e
    Rails.logger.error "Conversation action error: #{e.message}"
    flash[:error] = "Mesajlar yüklenirken bir hata oluştu"
    redirect_to root_path
  end

  def create
    Rails.logger.info "Create action: Started with params - #{params.inspect}"
    
    @message = current_user.sent_private_messages.build(message_params)
    @message.receiver = User.find(params[:user_id])
    
    Rails.logger.info "Create action: Built message - sender: #{@message.sender_id}, receiver: #{@message.receiver_id}"

    if @message.save
      Rails.logger.info "Create action: Message saved successfully"
      
      PrivateMessageChannel.broadcast_to(
        @receiver,
        message: render_to_string(partial: 'private_messages/message', locals: { message: @message })
      )
      
      respond_to do |format|
        format.html { redirect_to conversation_private_messages_path(user_id: @receiver.id) }
        format.js
      end
    else
      Rails.logger.error "Create action: Message save failed - #{@message.errors.full_messages}"
      
      respond_to do |format|
        format.html do
          flash[:error] = "Mesaj gönderilemedi: #{@message.errors.full_messages.join(', ')}"
          redirect_to conversation_private_messages_path(user_id: @receiver.id)
        end
        format.js { render :create_error }
      end
    end
  rescue => e
    Rails.logger.error "Create action error: #{e.message}"
    flash[:error] = "Mesaj gönderilirken bir hata oluştu"
    redirect_to root_path
  end

  private

  def set_receiver
    Rails.logger.info "Setting receiver with user_id: #{params[:user_id]}"
    if params[:user_id].blank?
      raise ActiveRecord::RecordNotFound, "User ID is missing"
    end
    @receiver = User.find(params[:user_id])
    Rails.logger.info "Receiver set to user: #{@receiver.id}"
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "Receiver not found: #{e.message}"
    flash[:error] = "Kullanıcı bulunamadı"
    redirect_to root_path
  end

  def check_friendship
    Rails.logger.info "Checking friendship between #{current_user.id} and #{@receiver.id}"
    unless current_user.friends_with?(@receiver)
      Rails.logger.info "Users are not friends"
      flash[:error] = "Sadece arkadaşlarınızla mesajlaşabilirsiniz"
      redirect_to root_path
    end
  end

  def message_params
    params.require(:private_message).permit(:content)
  end
end 