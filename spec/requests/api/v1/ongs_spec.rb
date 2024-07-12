# spec/requests/api/v1/ongs_spec.rb
require 'rails_helper'

RSpec.describe '/api/v1/ongs', type: :request do
  let!(:user) { create(:user) }
  let(:headers) { authenticated_header(user) }

  describe 'GET /ongs' do
    let!(:ongs) { create_list(:ong, 3) }

    it 'returns a list of ONGs' do
      get(api_v1_ongs_path, headers:)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect(json_response[:data].size).to eq(3)

      json_response[:data].each do |ong|
        expect_ong_attributes(ong)
      end
    end
  end

  describe 'GET /ongs/:id' do
    let!(:ong) { create(:ong, user:) }

    it 'returns the ONG' do
      get(api_v1_ong_path(ong), headers:)
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect_ong_attributes(json_response[:data])
    end
  end

  describe 'POST /ongs' do
    let(:valid_params) do
      {
        ong: {
          name: 'New ONG',
          city: 'New City',
          state: 'New State',
          description: 'New Description',
          email: 'newong@example.com',
          category: 1
        }
      }
    end

    it 'creates a new ONG' do
      post(api_v1_ongs_path, params: valid_params.to_json, headers:)
      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:message)
      expect(json_response[:message]).to eq("Ong 'New ONG' created successfully")

      expect(json_response).to have_key(:data)
      expect_ong_attributes(json_response[:data])
      expect(json_response[:data][:attributes][:name]).to eq('New ONG')
    end
  end

  describe 'PATCH /ongs/:id' do
    let!(:ong) { create(:ong, user:) }
    let(:update_params) do
      {
        ong: {
          name: 'Updated ONG'
        }
      }
    end

    it 'updates the ONG' do
      patch(api_v1_ong_path(ong), params: update_params.to_json, headers:)
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:message)
      expect(json_response[:message]).to eq("Ong 'Updated ONG' updated successfully")

      expect(json_response).to have_key(:data)
      expect_ong_attributes(json_response[:data])
      expect(json_response[:data][:attributes][:name]).to eq('Updated ONG')
    end
  end

  describe 'DELETE /ongs/:id' do
    let!(:ong) { create(:ong, user:) }

    it 'deletes the ONG' do
      delete(api_v1_ong_path(ong), headers:)
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:message)
      expect(json_response[:message]).to eq("Ong '#{ong.name}' deleted successfully")

      expect(json_response).to have_key(:data)
      expect_ong_attributes(json_response[:data])

      expect(Ong.find_by(id: ong.id)).to be_nil
    end
  end

  private

  def expect_ong_attributes(ong)
    expect(ong).to have_key(:id)
    expect(ong).to have_key(:type)
    expect(ong[:type]).to eq('ong')

    expect(ong).to have_key(:attributes)
    attributes = ong[:attributes]
    expect(attributes).to have_key(:id)
    expect(attributes).to have_key(:category)
    expect(attributes).to have_key(:city)
    expect(attributes).to have_key(:description)
    expect(attributes).to have_key(:email)
    expect(attributes).to have_key(:name)
    expect(attributes).to have_key(:state)
    expect(attributes).to have_key(:user_id)
    expect(attributes).to have_key(:created_at)
    expect(attributes).to have_key(:updated_at)
  end
end
