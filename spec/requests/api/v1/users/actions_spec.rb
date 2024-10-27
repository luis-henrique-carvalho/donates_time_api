# spec/requests/api/v1/users/actions_spec.rb

require 'rails_helper'

RSpec.describe "Api::V1::Users::Actions", type: :request do
  let!(:user) { create(:user) }
  let!(:ong) { create(:ong, user: user) }
  let!(:actions) { create_list(:action, 6, ong: ong, max_volunteers: 4) { |action| create(:volunteer, action: action, user: user) } }

  describe "GET /api/v1/users/:user_id/actions" do
    context "when the request is valid" do
      it "returns a paginated list of actions" do
        get api_v1_user_actions_path(user_id: user.id), params: { page: 1}

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)

        expect(body['data'].size).to eq(6)
        expect(body['pagy']).to include("count", "pages", "last", "page", "next")
      end

      it "includes action details and related associations" do
        get api_v1_user_actions_path(user_id: user.id), params: { page: 1, items: 12 }


        body = JSON.parse(response.body)
        first_action = body['data'].first

        expect(first_action['id']).to eq(actions.first.id)
        expect(first_action['title']).to eq(actions.first.title)
        expect(first_action['volunteer_count']).to eq(1)
        expect(first_action['ong_id']).to eq(ong.id)
      end
    end

    context "when a search query is provided" do
      let!(:user_2) { create(:user) }
      let!(:ong_2) { create(:ong, user: user_2) }
      let!(:filtered_action) { create(:action, title: "Specific Title", ong: ong_2) { |action| create(:volunteer, action: action, user: user_2) } }

      it "filters actions based on the search query" do
        get api_v1_user_actions_path(user_id: user_2.id), params: { q: { title_cont: "Specific" } }

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)

        expect(body['data']).to be_an(Array)
        expect(body['data'].size).to eq(1)
        expect(body['data'].first['title']).to eq("Specific Title")
      end
    end

    context "when the user does not exist" do
      it "returns a not found error" do
        get api_v1_user_actions_path(user_id: "non-existent")

        expect(response).to have_http_status(:not_found)
        body = JSON.parse(response.body)
        expect(body['error']).to eq("Couldn't find User with 'id'=non-existent")
      end
    end
  end
end
