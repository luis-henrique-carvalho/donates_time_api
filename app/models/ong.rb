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
class Ong < ApplicationRecord
  belongs_to :user
  has_many :actions, dependent: :destroy

  enum category: {
    education: 0,
    health: 1,
    environment: 2,
    animal_welfare: 3,
    arts_and_culture: 4,
    human_rights: 5,
    community_development: 6,
    science_and_technology: 7,
    disaster_relief: 8,
    sports: 9,
    youth: 10,
    seniors: 11
  }

  validates :name, :city, :state, :description, :email, :category, presence: true
  validates :user_id, uniqueness: true
end
