# == Schema Information
#
# Table name: ongs
#
#  id          :uuid             not null, primary key
#  category    :integer          default("education"), not null
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
FactoryBot.define do
  factory :ong do
    name { Faker::Name.name }
    city { Faker::Address.city }
    state { Faker::Address.state }
    description { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
    email { Faker::Internet.email }
    category { rand(0..11) }

    association :user
  end
end
