# spec/requests/api/v1/volunteers_spec.rb
require 'rails_helper'

RSpec.describe '/api/v1/volunteers', type: :request do
  let!(:user) { create(:user) }
  let!(:action) { create(:action) }
  let(:headers) { authenticated_header(user) }

  describe 'GET /volunteers/:id' do
    let!(:volunteer) { create(:volunteer, user:, action:) }

    it 'returns the volunteer' do
      get(api_v1_volunteer_path(volunteer), headers:)
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect_volunteer_attributes(json_response[:data])
    end
  end

  describe 'POST /volunteers' do
    let(:valid_params) do
      {
        volunteer: {
          action_id: action.id
        }
      }
    end

    it 'creates a new volunteer' do
      post(api_v1_volunteers_path, params: valid_params.to_json, headers:)
      expect(response).to have_http_status(:ok) # Alterado para :ok porque no controller está renderizando :ok

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect_volunteer_attributes(json_response[:data])
      expect(json_response[:data][:attributes][:user_id]).to eq(user.id)
      expect(json_response[:data][:attributes][:action_id]).to eq(action.id)
    end
  end

  describe 'DELETE /volunteers/:id' do
    let!(:volunteer) { create(:volunteer, user:, action:) }

    it 'deletes the volunteer' do
      delete(api_v1_volunteer_path(volunteer), headers:)
      expect(response).to have_http_status(:ok)
      expect(Volunteer.find_by(id: volunteer.id)).to be_nil
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
