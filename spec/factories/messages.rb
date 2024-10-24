# == Schema Information
#
# Table name: messages
#
#  id           :uuid             not null, primary key
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  channel_id   :uuid             not null
#  volunteer_id :uuid             not null
#
# Indexes
#
#  index_messages_on_channel_id    (channel_id)
#  index_messages_on_volunteer_id  (volunteer_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#  fk_rails_...  (volunteer_id => volunteers.id)
#
FactoryBot.define do
  factory :message do
    content { "MyText" }
    channel { nil }
    volunteer { nil }
  end
end
