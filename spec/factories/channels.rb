# == Schema Information
#
# Table name: channels
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  action_id  :uuid             not null
#
# Indexes
#
#  index_channels_on_action_id  (action_id)
#
# Foreign Keys
#
#  fk_rails_...  (action_id => actions.id)
#
FactoryBot.define do
  factory :channel do
    name { "MyString" }
    action { nil }
  end
end
