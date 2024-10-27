require 'rails_helper'

RSpec.describe "Api::V1::Chats::Messages", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/chats/messages/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/chats/messages/create"
      expect(response).to have_http_status(:success)
    end
  end

end
