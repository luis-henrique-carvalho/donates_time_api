# spec/requests/api/v1/actions/volunteers_spec.rb
require 'rails_helper'

RSpec.describe '/api/v1/actions/:action_id/volunteers', type: :request do
  let!(:user) { create(:user) }
  let!(:action) { create(:action) }
  let!(:volunteers) { create_list(:volunteer, 3, action:) }

  let(:headers) { authenticated_header(user) }

  describe 'GET /api/v1/actions/:action_id/volunteers' do
    it 'returns a list of volunteers for the action' do
      get(api_v1_action_volunteers_path(action), headers:)

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect(json_response[:data].size).to eq(3)

      json_response[:data].each do |volunteer|
        expect_volunteer_attributes(volunteer)
      end
    end
  end

  private

  def expect_volunteer_attributes(volunteer)
    expect(volunteer).to have_key(:id)
    expect(volunteer).to have_key(:user_id)
    expect(volunteer).to have_key(:action_id)
    expect(volunteer).to have_key(:created_at)
    expect(volunteer).to have_key(:updated_at)
  end
end
