require 'rails_helper'

RSpec.describe "Api::V1::Notifications", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/notifications/create"
      expect(response).to have_http_status(:success)
    end
  end

end
