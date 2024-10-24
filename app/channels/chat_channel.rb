class ChatChannel < ApplicationCable::Channel
  def subscribed
    chat = Chat.find(params[:chat_id])
    stream_for chat
  end

  def unsubscribed
    chat = Chat.find(params[:chat_id])
    stop_stream_for chat
  end

  def send_message
    chat = Chat.find(params[:chat_id])
    volunteer = Volunteer.find(params[:volunteer_id])

    message = chat.messages.create!(content: params[:content], volunteer: volunteer)

    ChatChannel.broadcast_to chat, message: MessageSerializer.render(message, root: :data)
  end
end
