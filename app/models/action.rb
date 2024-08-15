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
class Action < ApplicationRecord
  belongs_to :ong
  has_many :volunteers, dependent: :destroy

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

  enum status: {
    pending: 0,
    active: 1,
    completed: 2,
    canceled: 3
  }

  validates :title, :start_date, :end_date, :max_volunteers, :category, presence: true
  validates :title, uniqueness: true

  validate :action_limit_not_exceeded, on: :create

  def self.ransackable_attributes(_auth_object = nil)
    %w[title category state category]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[ong volunteers]
  end

  private

  def action_limit_not_exceeded
    return unless ong.actions.count >= ong.actions_limit

    errors.add(:base, 'Limite de ações atingido para esta ONG')
  end
end
