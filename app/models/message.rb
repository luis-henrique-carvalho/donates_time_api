# == Schema Information
#
# Table name: messages
#
#  id           :uuid             not null, primary key
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  chat_id      :uuid             not null
#  volunteer_id :uuid             not null
#
# Indexes
#
#  index_messages_on_chat_id       (chat_id)
#  index_messages_on_volunteer_id  (volunteer_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_id => chats.id)
#  fk_rails_...  (volunteer_id => volunteers.id)
#
class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :volunteer

  after_create_commit :broadcast_message

  private

  def broadcast_message
    ActionCable.server.broadcast("chat_#{chat_id}", MessageSerializer.render_as_json(self))
  end
end
