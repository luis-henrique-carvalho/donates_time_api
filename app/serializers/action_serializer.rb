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
class ActionSerializer < ApplicationSerializer
  identifier :id

  fields :id, :title, :description, :start_date, :end_date, :status,
         :max_volunteers, :category, :created_at, :updated_at, :ong_id

  field :volunteer_count do |action|
    action.volunteers.size
  end

  view :with_ong do
    association :ong, blueprint: OngSerializer
  end

  view :with_volunteers do
    association :volunteers, blueprint: VolunteerSerializer
  end

  view :with_ong_and_volunteers do
    include_view :with_ong
    include_view :with_volunteers
  end
end
