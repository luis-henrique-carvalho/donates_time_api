# == Schema Information
#
# Table name: ongs
#
#  id            :uuid             not null, primary key
#  actions_limit :integer          default(6), not null
#  category      :integer          default("education"), not null
#  city          :string           not null
#  description   :text             not null
#  email         :string           not null
#  name          :string           not null
#  state         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :uuid             not null
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
  has_many :volunteers, through: :actions

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

  scope :with_stats, lambda {
    includes(actions: :volunteers)
      .left_joins(actions: :volunteers)
      .select(
        'ongs.*',
        'COUNT(DISTINCT volunteers.id) AS volunteers_total',
        'SUM(actions.max_volunteers) AS actions_slots_total',
        'SUM(actions.max_volunteers) - COUNT(DISTINCT volunteers.id) AS actions_slots_available',
        'COUNT(DISTINCT CASE WHEN volunteers.confirmed = TRUE THEN volunteers.id END) AS confirmed_volunteers'
      )
      .group('ongs.id')
  }

  def self.ransackable_attributes(_auth_object = nil)
    %w[name category state category]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user actions volunteers]
  end

  def reached_action_limit?
    actions.count >= actions_limit
  end

  def confirmed_volunteers
    volunteers.where(confirmed: true).count
  end
end
