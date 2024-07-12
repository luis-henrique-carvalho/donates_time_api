# == Schema Information
#
# Table name: volunteers
#
#  id         :uuid             not null, primary key
#  confirmed  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  action_id  :uuid             not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_volunteers_on_action_id              (action_id)
#  index_volunteers_on_user_id                (user_id)
#  index_volunteers_on_user_id_and_action_id  (user_id,action_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (action_id => actions.id)
#  fk_rails_...  (user_id => users.id)
#
class VolunteerSerializer
  include JSONAPI::Serializer

  attributes :id, :confirmed, :user_id, :action_id, :created_at, :updated_at
end
