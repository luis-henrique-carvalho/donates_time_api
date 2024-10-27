class ChatSerializer < ApplicationSerializer
  identifier :id

  fields :id, :name, :created_at, :updated_at, :action_id
end
