# spec/requests/api/v1/actions_spec.rb
require 'rails_helper'

RSpec.describe '/api/v1/actions', type: :request do
  let!(:user) { create(:user) }
  let!(:ong) { create(:ong, user:) }
  let(:headers) { authenticated_header(user) }

  describe 'GET /actions' do
    let!(:actions) { create_list(:action, 3) }
    it 'returns a list of actions' do
      get(api_v1_actions_path, headers:)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect(json_response[:data].size).to eq(3)

      json_response[:data].each do |action|
        expect_action_attributes(action)
      end
    end
  end

  describe 'GET /actions/:id' do
    let!(:action) { create(:action) }

    it 'returns the action' do
      get(api_v1_action_path(action), headers:)
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect_action_attributes(json_response[:data])
    end
  end

  describe 'POST /actions' do
    let(:valid_params) do
      {
        title: 'New action',
        start_date: Time.now,
        end_date: Time.now + 1.day,
        max_volunteers: 5,
        category: 1,
        description: 'New Description',
        ong_id: ong.id
      }
    end

    it 'creates a new action' do
      post(api_v1_actions_path, params: valid_params.to_json, headers:)
      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect_action_attributes(json_response[:data])
      expect(json_response[:data][:attributes][:title]).to eq('New action')
    end
  end

  describe 'PATCH /actions/:id' do
    let!(:action) { create(:action, ong:) }
    let(:update_params) do
      {
        title: 'Updated action'
      }
    end

    it 'updates the action' do
      patch(api_v1_action_path(action), params: update_params.to_json, headers:)
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect_action_attributes(json_response[:data])
      expect(json_response[:data][:attributes][:title]).to eq('Updated action')
    end
  end

  describe 'DELETE /actions/:id' do
    let!(:action) { create(:action, ong:) }
    it 'deletes the action' do
      delete(api_v1_action_path(action), headers:)
      expect(response).to have_http_status(:no_content)
      expect(Action.find_by(id: action.id)).to be_nil
    end
  end

  private

  def expect_action_attributes(action)
    expect(action).to have_key(:id)
    expect(action).to have_key(:type)
    expect(action[:type]).to eq('action')

    expect(action).to have_key(:attributes)
    attributes = action[:attributes]
    expect(attributes).to have_key(:id)
    expect(attributes).to have_key(:category)
    expect(attributes).to have_key(:description)
    expect(attributes).to have_key(:end_date)
    expect(attributes).to have_key(:max_volunteers)
    expect(attributes).to have_key(:start_date)
    expect(attributes).to have_key(:title)
    expect(attributes).to have_key(:ong_id)
    expect(attributes).to have_key(:created_at)
    expect(attributes).to have_key(:updated_at)
  end
end
