require 'rails_helper'

RSpec.describe "LocationsController", type: :request do
  let!(:admin) { create(:user, isAdmin: :admin, password: "password", password_confirmation: "password") }
  let!(:user) { create(:user, password: "password", password_confirmation: "password") }
  let!(:locations) { create_list(:location, 5) }
  let(:location) { locations.first }
  before(:each) do
    token = JsonWebToken.encode(user_id: admin.id)
    @headers = { 'Authorization' => "Bearer #{token}" }
  end

  describe "GET /locations" do
    it "returns all locations" do
      get locations_path, headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(5)
    end
  end

  describe "GET /locations/:id" do
    context "when the record exists" do
      it "returns the location" do
        get "/locations/#{location.id}", headers: @headers
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['id']).to eq(location.id)
      end
    end

    context "when the record does not exist" do
      let(:location_id) { 0 }

      it "returns status code 404" do
        get "/locations/#{location_id}", headers: @headers
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST /locations" do
    let(:valid_attributes) { { name: "New Location", address: "123 New Street" } }

    context "when the request is valid" do
      it "creates a location" do
        expect {
          post locations_path, params: { location: valid_attributes }, headers: @headers
        }.to change(Location, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      let(:invalid_attributes) { { name: nil } }

      it "returns status code 422" do
        post locations_path, params: { location: invalid_attributes }, headers: @headers
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        post locations_path, params: { location: invalid_attributes }, headers: @headers
        expect(JSON.parse(response.body)['name']).to match(["can't be blank"])
      end
    end
  end

  describe "PUT /locations/:id" do
    let(:valid_attributes) { { name: "Updated Location" } }

    context "when the record exists" do
      it "updates the record" do
        put "/locations/#{location.id}", params: { location: valid_attributes }, headers: @headers
        expect(response).to have_http_status(200)
        updated_location = Location.find(location.id)
        expect(updated_location.name).to eq("Updated Location")
      end
    end

    context "when the record does not exist" do
      let(:location_id) { 0 }

      it "returns status code 404" do
        put "/locations/#{location_id}", params: { location: valid_attributes }, headers: @headers
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "DELETE /locations/:id" do
    it "deletes the record" do
      expect {
        delete "/locations/#{location.id}", headers: @headers
      }.to change(Location, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end

  describe "GET /locations/search" do
    context "with query" do
      it "returns the matching locations" do
        get locations_search_path, params: { query: location.name }, headers: @headers
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).size).to eq(1)
        expect(JSON.parse(response.body).first['name']).to eq(location.name)
      end
    end

    context "without query" do
      it "returns all locations" do
        get locations_search_path, headers: @headers
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).size).to eq(5)
      end
    end
  end
end
