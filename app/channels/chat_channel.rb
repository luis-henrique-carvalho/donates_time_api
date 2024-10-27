class ChatChannel < ApplicationCable::Channel
  before_subscribe :find_chat
  # before_subscribe :verifi_current_user

  def subscribed
    stream_from "chat_#{@chat.id}"
  end

  def unsubscribed
    # Qualquer ação de limpeza quando o usuário desconectar
  end

  private

  def find_chat
    return if @chat = Chat.find(params[:chat_id])

    reject
  end

  def verifi_current_user
    return if current_user.vollunteers.include?(@chat.volunteer)

    reject
  end
end
