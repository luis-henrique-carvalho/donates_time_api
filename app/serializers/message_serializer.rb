
class MessageSerializer < ApplicationSerializer
  identifier :id

  fields :id, :content, :chat_id, :volunteer_id, :created_at, :updated_at

  association :volunteer, blueprint: VolunteerSerializer
  association :chat, blueprint: ChatSerializer
end
