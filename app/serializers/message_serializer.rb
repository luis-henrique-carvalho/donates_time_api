
class MessageSerializer < ApplicationSerializer
  identifier :id

  fields :id, :content, :created_at, :updated_at

  association :volunteer, blueprint: VolunteerSerializer
  association :chat, blueprint: ChatSerializer
end
