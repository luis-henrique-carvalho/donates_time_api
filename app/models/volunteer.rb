# == Schema Information
#
# Table name: volunteers
#
#  id         :uuid             not null, primary key
#  confirmed  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  action_id  :uuid             not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_volunteers_on_action_id              (action_id)
#  index_volunteers_on_user_id                (user_id)
#  index_volunteers_on_user_id_and_action_id  (user_id,action_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (action_id => actions.id)
#  fk_rails_...  (user_id => users.id)
#
class Volunteer < ApplicationRecord
  belongs_to :user
  belongs_to :action

  has_one :ong, through: :action

  validates :user_id, :action_id, presence: true
  validates :user_id, uniqueness: { scope: :action_id }

  validate :action_limit_not_exceeded, on: :create

  def confirm_presence
    update(confirmed: true)
  end

  private

  def action_limit_not_exceeded
    return unless action.volunteers.count >= action.max_volunteers

    errors.add(:action, 'is full')
    throw(:abort)
  end
end
