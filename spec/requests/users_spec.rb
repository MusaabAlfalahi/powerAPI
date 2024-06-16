require 'rails_helper'

RSpec.describe "UserController", type: :request do
  let!(:admin) { create(:user, isAdmin: :admin) }
  let!(:user) { create(:user) }

  describe "POST /users" do
    context "when logged in as an admin" do
      it "creates a new user" do
        token = JsonWebToken.encode(user_id: admin.id)
        headers = { 'Authorization' => "Bearer #{token}" }

        post signup_path, params: { email: "new_user@example.com", password: "password", password_confirmation: "password" }, headers: headers

        expect(response).to have_http_status(:created)
        expect(User.find_by(email: "new_user@example.com")).not_to be_nil
      end
    end

    context "when logged in as a non-admin" do
      it "does not allow user creation" do
        token = JsonWebToken.encode(user_id: user.id)
        headers = { 'Authorization' => "Bearer #{token}" }

        post signup_path, params: { email: "new_user@example.com", password: "password", password_confirmation: "password" }, headers: headers

        expect(response).to have_http_status(:unauthorized)
        expect(User.find_by(email: "new_user@example.com")).to be_nil
      end
    end

    context "when not logged in" do
      it "does not allow user creation" do
        post signup_path, params: { email: "new_user@example.com", password: "password", password_confirmation: "password" }

        expect(response).to have_http_status(:unauthorized)
        expect(User.find_by(email: "new_user@example.com")).to be_nil
      end
    end
  end
end
