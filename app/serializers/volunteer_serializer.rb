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
class VolunteerSerializer < ApplicationSerializer
  identifier :id

  fields :id, :confirmed, :user_id, :action_id, :created_at, :updated_at

  view :default do
    field :user_name do |volunteer|
      volunteer.user.name
    end

    field :user_email do |volunteer|
      volunteer.user.email
    end

    field :action_title do |volunteer|
      volunteer.action.title
    end

    field :action_ong_name do |volunteer|
      volunteer.action.ong.name
    end
  end

  view :with_user do
    association :user, blueprint: UserSerializer
  end

  view :with_action do
    association :action, blueprint: ActionSerializer
  end

  view :with_user_and_action do
    association :user, blueprint: UserSerializer
    association :action, blueprint: ActionSerializer
  end
end
