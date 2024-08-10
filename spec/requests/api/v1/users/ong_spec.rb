require 'rails_helper'

RSpec.describe '/api/v1/users/:user_id/ong', type: :request do
  let!(:user) { create(:user) }
  let(:headers) { authenticated_header(user) }

  describe 'GET /api/v1/users/:user_id/ong' do
    let!(:ong) { create(:ong, user:) }
    let!(:action) { create(:action, ong:) }
    let!(:volunteer) { create(:volunteer, action:, user:) }

    it 'returns the ONG' do
      get(api_v1_users_ong_index_path(user_id: user.id), headers:)
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect_ong_attributes(json_response[:data])
    end
  end

  def expect_ong_attributes(ong)
    expect(ong).to have_key(:id)
    expect(ong).to have_key(:category)
    expect(ong).to have_key(:city)
    expect(ong).to have_key(:description)
    expect(ong).to have_key(:email)
    expect(ong).to have_key(:name)
    expect(ong).to have_key(:state)
    expect(ong).to have_key(:user_id)
    expect(ong).to have_key(:created_at)
    expect(ong).to have_key(:updated_at)
    expect(ong).to have_key(:volunteers_total)
    expect(ong).to have_key(:actions_slots_total)
    expect(ong).to have_key(:actions_slots_available)
    expect(ong).to have_key(:confirmed_volunteers)
  end
end
