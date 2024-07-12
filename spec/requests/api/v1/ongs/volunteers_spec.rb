# spec/requests/api/v1/ongs/volunteers_spec.rb
require 'rails_helper'

RSpec.describe '/api/v1/ongs/:ong_id/volunteers', type: :request do
  let!(:user) { create(:user) }
  let!(:ong) { create(:ong, user:) }
  let!(:actions) do
    create_list(:action, 3, ong:) do |action|
      create(:volunteer, action:)
    end
  end

  let(:headers) { authenticated_header(user) }

  describe 'GET /api/v1/ongs/:ong_id/volunteers' do
    it 'returns a list of volunteers for the ONG' do
      get(api_v1_ong_volunteers_path(ong), headers:)

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect(json_response[:data].size).to eq(3)

      json_response[:data].each do |volunteer|
        expect_volunteer_attributes(volunteer)
      end
    end
  end

  describe 'PUT /api/v1/ongs/:ong_id/volunteers/:id/confirm_presence' do
    let(:volunteer) { ong.volunteers.first }

    it 'confirms the presence of a volunteer' do
      put(confirm_presence_api_v1_ong_volunteer_path(ong, volunteer), headers:)

      debugger
      expect(response).to have_http_status(:ok)
      expect(json_response).to have_key(:message)
      expect(json_response[:message]).to eq('Presence confirmed successfully')

      expect(json_response).to have_key(:data)
      expect(json_response[:data][:attributes][:confirmed]).to eq(true)
      expect_volunteer_attributes(json_response[:data])
    end
  end

  private

  def expect_volunteer_attributes(volunteer)
    expect(volunteer).to have_key(:id)
    expect(volunteer).to have_key(:type)
    expect(volunteer[:type]).to eq('volunteer')

    expect(volunteer).to have_key(:attributes)
    attributes = volunteer[:attributes]
    expect(attributes).to have_key(:id)
    expect(attributes).to have_key(:confirmed)
    expect(attributes).to have_key(:user_id)
    expect(attributes).to have_key(:action_id)
    expect(attributes).to have_key(:created_at)
    expect(attributes).to have_key(:updated_at)
  end
end
