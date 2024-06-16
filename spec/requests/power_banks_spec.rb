require 'rails_helper'

RSpec.describe "PowerBanksController", type: :request do
  let!(:admin) { create(:user, isAdmin: :admin) }
  let!(:station) { create(:station) }
  let!(:warehouse) { create(:warehouse) }
  let!(:user) { create(:user) }
  let!(:power_bank) { create(:power_bank) }

  before(:each) do
    token = JsonWebToken.encode(user_id: admin.id)
    @headers = { 'Authorization' => "Bearer #{token}" }
  end

  describe "GET /power_banks" do
    it "returns a list of power banks" do
      create_list(:power_bank, 3)
      get '/power_banks', headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(4)
    end
  end

  describe "GET /power_banks/:id" do
    it "returns a power bank" do
      get "/power_banks/#{power_bank.id}", headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["id"]).to eq(power_bank.id)
    end
  end

  describe "POST /power_banks" do
    context "with valid attributes" do
      it "creates a new power bank" do
        power_bank_params = attributes_for(:power_bank).merge(station_id: station.id)
        expect {
          post '/power_banks', params: { power_bank: power_bank_params }, headers: @headers
        }.to change(PowerBank, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid attributes" do
      it "does not create a new power bank" do
        expect {
          post '/power_banks', params: { power_bank: { name: nil } }, headers: @headers
        }.not_to change(PowerBank, :count)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PUT /power_banks/:id" do
    context "with valid attributes" do
      it "updates the power bank" do
        new_name = "Updated Power Bank"
        put "/power_banks/#{power_bank.id}", params: { power_bank: { name: new_name } }, headers: @headers
        expect(response).to have_http_status(200)
        power_bank.reload
        expect(power_bank.name).to eq(new_name)
      end
    end

    context "with invalid attributes" do
      it "does not update the power bank" do
        original_name = power_bank.name
        put "/power_banks/#{power_bank.id}", params: { power_bank: { name: nil } }, headers: @headers
        expect(response).to have_http_status(:unprocessable_content)
        power_bank.reload
        expect(power_bank.name).to eq(original_name)
      end
    end
  end

  describe "DELETE /power_banks/:id" do
    it "destroys the power bank" do
      expect {
        delete "/power_banks/#{power_bank.id}", headers: @headers
      }.to change(PowerBank, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end

  describe "PUT /power_banks/:id/take" do
    it "assigns the power bank to the current user" do
      put "/power_banks/#{power_bank.id}/take", headers: @headers
      expect(response).to have_http_status(200)
      power_bank.reload
      expect(power_bank.status).to eq('in_use')
      expect(power_bank.user_id).to eq(admin.id)
    end
  end

  describe "PUT /power_banks/:id/return" do
    it "returns the power bank and sets it to available" do
      power_bank.update(user: admin, status: 'in_use')
      put "/power_banks/#{power_bank.id}/return", headers: @headers
      expect(response).to have_http_status(200)
      power_bank.reload
      expect(power_bank.status).to eq('available')
      expect(power_bank.user_id).to be_nil
    end
  end

  describe "PUT /power_banks/:id/assign_to_station" do
    it "assigns the power bank to a station" do
      put "/power_banks/#{power_bank.id}/station", params: { station_id: station.id }, headers: @headers
      expect(response).to have_http_status(200)
      power_bank.reload
      expect(power_bank.station_id).to eq(station.id)
    end

    it "returns an error if the station limit is reached" do
      create_list(:power_bank, 10, station: station)
      put "/power_banks/#{power_bank.id}/station", params: { station_id: station.id }, headers: @headers
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)['error']).to eq('Power bank limit for this station reached')
    end
  end

  describe "PUT /power_banks/:id/warehouse" do
    it "assigns the power bank to a warehouse" do
      put "/power_banks/#{power_bank.id}/warehouse", params: { warehouse_id: warehouse.id }, headers: @headers
      expect(response).to have_http_status(200)
      power_bank.reload
      expect(power_bank.warehouse_id).to eq(warehouse.id)
    end
  end

  describe "PUT /power_banks/:id/user" do
    it "assigns the power bank to a user" do
      put "/power_banks/#{power_bank.id}/user", params: { user_id: user.id }, headers: @headers
      expect(response).to have_http_status(200)
      power_bank.reload
      expect(power_bank.user_id).to eq(user.id)
    end
  end

  describe "GET /power_banks/search" do
    it "returns filtered power banks" do
      power_bank1 = create(:power_bank, name: "Power Bank A")
      power_bank2 = create(:power_bank, name: "Power Bank B")
      get "/power_banks/search", params: { query: "A" }, headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body)[0]["name"]).to eq(power_bank1.name)
    end

    it "returns all power banks when no query is present" do
      power_banks = create_list(:power_bank, 3)
      get "/power_banks/search", headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(4)
    end
  end
end
