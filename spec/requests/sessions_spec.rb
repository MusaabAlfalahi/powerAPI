require 'rails_helper'

RSpec.describe "SessionsController", type: :request do
  let(:user) { create(:user) }

  describe "POST /login" do
    context "with valid credentials" do
      it "returns a JWT token" do
        post login_path, params: { email: user.email, password: "password" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key("token")
      end
    end

    context "with invalid credentials" do
      it "returns an error" do
        post login_path, params: { email: user.email, password: "wrong_password" }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)["error"]).to eq("Invalid email or password")
      end
    end
  end

  describe "DELETE /logout" do
    before do
      post login_path, params: { email: user.email, password: "password" }
      @token = JSON.parse(response.body)["token"]
    end

    it "logs out the user" do
      delete logout_path, headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(:no_content)
    end
  end
end
