require 'rails_helper'

RSpec.describe "WarehousesController", type: :request do
  let!(:admin) { create(:user, isAdmin: :admin, password: "password", password_confirmation: "password") }

  before(:each) do
    token = JsonWebToken.encode(user_id: admin.id)
    @headers = { 'Authorization' => "Bearer #{token}" }
  end

  describe "GET /warehouses" do
    it "returns a list of warehouses" do
      create_list(:warehouse, 3)
      get '/warehouses', headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /warehouses/:id" do
    it "returns a warehouse" do
      warehouse = create(:warehouse)
      get "/warehouses/#{warehouse.id}", headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["id"]).to eq(warehouse.id)
    end
  end

  describe "POST /warehouses" do
    context "with valid attributes" do
      it "creates a new warehouse" do
        warehouse_params = attributes_for(:warehouse)
        expect {
          post '/warehouses', params: { warehouse: warehouse_params }, headers: @headers
        }.to change(Warehouse, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid attributes" do
      it "does not create a new warehouse" do
        expect {
          post '/warehouses', params: { warehouse: { name: nil } }, headers: @headers
        }.not_to change(Warehouse, :count)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PUT /warehouses/:id" do
    let(:warehouse) { create(:warehouse) }

    context "with valid attributes" do
      it "updates the warehouse" do
        new_name = "Updated Warehouse Name"
        put "/warehouses/#{warehouse.id}", params: { warehouse: { name: new_name } }, headers: @headers
        expect(response).to have_http_status(200)
        warehouse.reload
        expect(warehouse.name).to eq(new_name)
      end
    end

    context "with invalid attributes" do
      it "does not update the warehouse" do
        original_name = warehouse.name
        put "/warehouses/#{warehouse.id}", params: { warehouse: { name: nil } }, headers: @headers
        expect(response).to have_http_status(:unprocessable_content)
        warehouse.reload
        expect(warehouse.name).to eq(original_name)
      end
    end
  end

  describe "DELETE /warehouses/:id" do
    it "destroys the warehouse" do
      warehouse = create(:warehouse)  # Assuming you have a factory named :warehouse
      expect {
        delete "/warehouses/#{warehouse.id}", headers: @headers
      }.to change(Warehouse, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end

  describe "GET /warehouses/search" do
    it "returns filtered warehouses" do
      warehouse1 = create(:warehouse, name: "Warehouse A")
      get "/warehouses/search", params: { query: "A" }, headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body)[0]["name"]).to eq(warehouse1.name)
    end

    it "returns all warehouses when no query is present" do
      create_list(:warehouse, 3)
      get "/warehouses/search", headers: @headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end
end
