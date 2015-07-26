require 'rails_helper'

RSpec.describe "EditRequests", type: :request do
  describe "GET /edit_requests" do
    it "works! (now write some real specs)" do
      get edit_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
