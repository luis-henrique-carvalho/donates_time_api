# == Schema Information
#
# Table name: actions
#
#  id             :uuid             not null, primary key
#  description    :text
#  end_date       :datetime         not null
#  max_volunteers :integer          not null
#  start_date     :datetime         not null
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
    title { "MyString" }
    start_date { "2024-07-10 03:06:12" }
    end_date { "2024-07-10 03:06:12" }
    description { "MyText" }
    max_volunteers { 1 }
    ong { nil }
  end
end
