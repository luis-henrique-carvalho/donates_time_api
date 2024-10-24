# == Schema Information
#
# Table name: messages
#
#  id           :uuid             not null, primary key
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  chat_id      :uuid             not null
#  volunteer_id :uuid             not null
#
# Indexes
#
#  index_messages_on_chat_id       (chat_id)
#  index_messages_on_volunteer_id  (volunteer_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_id => chats.id)
#  fk_rails_...  (volunteer_id => volunteers.id)
#
require 'rails_helper'

RSpec.describe Message, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
