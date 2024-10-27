# == Schema Information
#
# Table name: chats
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  action_id  :uuid             not null
#
# Indexes
#
#  index_chats_on_action_id  (action_id)
#
# Foreign Keys
#
#  fk_rails_...  (action_id => actions.id)
#
FactoryBot.define do
  factory :chat do
    name { Faker::Name.name }
    association :action
  end
end
