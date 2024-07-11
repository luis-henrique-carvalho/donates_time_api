class VolunteerSerializer
  include JSONAPI::Serializer

  attributes :id, :user_id, :action_id, :created_at, :updated_at

  belongs_to :user
  belongs_to :action
end
