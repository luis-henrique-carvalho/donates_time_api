require "rails_helper"

RSpec.describe Api::V1::ActionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/actions").to route_to("api/v1/actions#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/actions/1").to route_to("api/v1/actions#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/v1/actions").to route_to("api/v1/actions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/actions/1").to route_to("api/v1/actions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/actions/1").to route_to("api/v1/actions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/actions/1").to route_to("api/v1/actions#destroy", id: "1")
    end
  end
end
