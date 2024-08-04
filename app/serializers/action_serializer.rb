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
class ActionSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description, :start_date, :end_date,
             :max_volunteers, :category, :created_at, :updated_at, :ong_id

  belongs_to :ong
end
