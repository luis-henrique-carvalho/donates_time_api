# == Schema Information
#
# Table name: ongs
#
#  id            :uuid             not null, primary key
#  actions_limit :integer          default(6), not null
#  category      :integer          default("education"), not null
#  city          :string           not null
#  description   :text             not null
#  email         :string           not null
#  name          :string           not null
#  state         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :uuid             not null
#
# Indexes
#
#  index_ongs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class OngSerializer < ApplicationSerializer
  identifier :id

  fields :id, :category, :city, :description, :email, :name, :state, :user_id, :created_at, :updated_at

  field :volunteers_total do |ong|
    ong.volunteers.distinct.count
  end

  view :with_user do
    association :user, blueprint: UserSerializer
  end

  view :with_actions do
    include_view :with_user
    association :actions, blueprint: ActionSerializer
  end

  view :overview do
    include_view :with_actions

    field :actions_slots_total
    field :actions_slots_available
    field :confirmed_volunteers
  end
end
