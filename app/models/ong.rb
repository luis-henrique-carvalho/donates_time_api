# == Schema Information
#
# Table name: ongs
#
#  id          :uuid             not null, primary key
#  city        :string           not null
#  description :text             not null
#  email       :string           not null
#  name        :string           not null
#  state       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :uuid             not null
#
# Indexes
#
#  index_ongs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Ong < ApplicationRecord
  belongs_to :user
end
