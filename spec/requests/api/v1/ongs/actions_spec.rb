# spec/requests/api/v1/ongs/actions_spec.rb
require 'rails_helper'

RSpec.describe 'Api::V1::Ongs::Actions', type: :request do
  let!(:user) { create(:user) }
  let!(:ong) { create(:ong, user:) }
  let!(:actions) { create_list(:action, 3, ong:) }
  let(:headers) { authenticated_header(user) }

  describe 'GET /api/v1/ongs/:ong_id/actions' do
    it 'returns a list of actions for the ONG' do
      get(api_v1_ong_actions_path(ong), headers:)

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect(json_response[:data].size).to eq(3)

      json_response[:data].each do |action|
        expect_action_attributes(action)
      end
    end
  end

  private

  def expect_action_attributes(action)
    expect(action).to have_key(:id)
    expect(action).to have_key(:category)
    expect(action).to have_key(:description)
    expect(action).to have_key(:end_date)
    expect(action).to have_key(:max_volunteers)
    expect(action).to have_key(:start_date)
    expect(action).to have_key(:title)
    expect(action).to have_key(:ong_id)
    expect(action).to have_key(:created_at)
    expect(action).to have_key(:updated_at)
  end
end
