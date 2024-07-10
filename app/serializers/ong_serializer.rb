class OngSerializer
  include JSONAPI::Serializer
  attributes :id, :category, :city, :description, :email, :name, :state, :user_id, :created_at, :updated_at
end
