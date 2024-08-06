require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let!(:user) { create(:user) }
  let!(:ong) { create(:ong, user:) }
  let(:headers) { authenticated_header(user) }

  describe 'GET /users:id' do
    it 'returns the user' do
      get(api_v1_user_path(user), headers:)

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:data)
      expect_user_attributes(json_response[:data])
    end
  end

  def expect_user_attributes(user)
    expect(user).to have_key(:id)
    expect(user).to have_key(:name)
    expect(user).to have_key(:email)

    expect(user[:ong]).to have_key(:id)
  end
end
