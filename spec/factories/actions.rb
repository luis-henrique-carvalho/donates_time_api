# == Schema Information
#
# Table name: actions
#
#  id             :uuid             not null, primary key
#  category       :integer          default("education"), not null
#  description    :text
#  end_date       :datetime         not null
#  max_volunteers :integer          not null
#  start_date     :datetime         not null
#  status         :integer          default("pending"), not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ong_id         :uuid             not null
#
# Indexes
#
#  index_actions_on_ong_id  (ong_id)
#
# Foreign Keys
#
#  fk_rails_...  (ong_id => ongs.id)
#
FactoryBot.define do
  factory :action do
    title { Faker::Name.name }
    start_date { Time.now - 2.days }
    end_date { Time.now - 1.day }
    description { Faker::Lorem.paragraph_by_chars(number: 1024, supplemental: false) }
    max_volunteers { rand(1..10) }

    association :ong
  end
end
