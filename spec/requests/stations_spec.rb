require 'rails_helper'

RSpec.describe "StationsController", type: :request do
  let!(:admin) { create(:user, isAdmin: :admin, password: "password", password_confirmation: "password") }
  let!(:location) { create(:location) }
  let!(:warehouse) { create(:warehouse) }

  before(:each) do
    token = JsonWebToken.encode(user_id: admin.id)
    @headers = { 'Authorization' => "Bearer #{token}" }
  end

  describe "GET /stations" do
    it "returns a list of stations" do
      create_list(:station, 3)
      get '/stations', headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /stations/:id" do
    it "returns a station" do
      station = create(:station)
      get "/stations/#{station.id}", headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["id"]).to eq(station.id)
    end
  end

  describe "POST /stations" do
    context "with valid attributes" do
      it "creates a new station" do
        station_params = attributes_for(:station)
        expect {
          post '/stations', params: { station: station_params }, headers: @headers
        }.to change(Station, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid attributes" do
      it "does not create a new station" do
        expect {
          post '/stations', params: { station: { name: nil } }, headers: @headers
        }.not_to change(Station, :count)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PUT /stations/:id" do
    let(:station) { create(:station) }

    context "with valid attributes" do
      it "updates the station" do
        new_name = "Updated Station Name"
        put "/stations/#{station.id}", params: { station: { name: new_name } }, headers: @headers
        expect(response).to have_http_status(200)
        station.reload
        expect(station.name).to eq(new_name)
      end
    end

    context "with invalid attributes" do
      it "does not update the station" do
        original_name = station.name
        put "/stations/#{station.id}", params: { station: { name: nil } }, headers: @headers
        expect(response).to have_http_status(:unprocessable_content)
        station.reload
        expect(station.name).to eq(original_name)
      end
    end
  end

  describe "DELETE /stations/:id" do
    it "destroys the station" do
      station = create(:station)
      expect {
        delete "/stations/#{station.id}", headers: @headers
      }.to change(Station, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end

  describe "put /stations/:id/location" do
    it "assigns the station to a location" do
      station = create(:station)
      put "/stations/#{station.id}/location", params: { location_id: location.id }, headers: @headers
      expect(response).to have_http_status(200)
      station.reload
      expect(station.location_id).to eq(location.id)
    end
  end

  describe "put /stations/:id/warehouse" do
    it "assigns the station to a warehouse" do
      station = create(:station)
      put "/stations/#{station.id}/warehouse", params: { warehouse_id: warehouse.id }, headers: @headers
      expect(response).to have_http_status(200)
      station.reload
      expect(station.warehouse_id).to eq(warehouse.id)
    end
  end

  describe "GET /stations/search" do
    it "returns filtered stations" do
      station1 = create(:station, name: "Station A")
      station2 = create(:station, name: "Station B")
      get "/stations/search", params: { query: "A" }, headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body)[0]["name"]).to eq(station1.name)
    end

    it "returns all stations when no query is present" do
      stations = create_list(:station, 3)
      get "/stations/search", headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end
end
