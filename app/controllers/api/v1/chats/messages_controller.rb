class Api::V1::Chats::MessagesController < Api::V1::ApplicationController
  before_action :set_chat, only: %i[index create]

  def index
    messages = @chat.messages.order(created_at: :asc)

    render json: MessageSerializer.render_as_json(messages, root: :data), status: :ok
  end

  def create
    message = @chat.messages.create!(message_params)

    render json: {
      message: default_messages('Message', name: @chat.id)[:created],
      data: MessageSerializer.render(message, root: :data)
    }, status: :created
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content, :volunteer_id)
  end
end
