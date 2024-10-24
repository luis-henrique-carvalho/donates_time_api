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
require 'rails_helper'

RSpec.describe Message, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
