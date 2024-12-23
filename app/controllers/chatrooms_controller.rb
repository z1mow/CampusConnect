class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]

  def index
    @chatrooms = Chatroom.all
    @message = Message.new
    @messages = Message.all
  end

  def show
    @messages = @chatroom.messages.includes(:user)
    @message = Message.new
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      redirect_to chatroom_path(@chatroom), notice: "Chatroom başarıyla oluşturuldu!"
    else
      flash.now[:alert] = "Chatroom oluşturulamadı."
      render :new
    end
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to chatrooms_path, alert: "Chatroom bulunamadı."
  end

  def chatroom_params
    params.require(:chatroom).permit(:name, :description)
  end
end
