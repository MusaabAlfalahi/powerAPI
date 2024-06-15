require 'rails_helper'

RSpec.describe PowerBank, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      power_bank = build(:power_bank)
      expect(power_bank).to be_valid
    end

    it 'is not valid without a name' do
      power_bank = build(:power_bank, name: nil)
      expect(power_bank).not_to be_valid
    end

    it 'defaults to available status' do
      power_bank = build(:power_bank)
      expect(power_bank.status).to eq('available')
    end
  end

  describe 'associations' do
    it 'can belong to a station' do
      station = create(:station)
      power_bank = create(:power_bank, station: station)
      expect(power_bank.station).to eq(station)
    end

    it 'can belong to a warehouse' do
      warehouse = create(:warehouse)
      power_bank = create(:power_bank, warehouse: warehouse)
      expect(power_bank.warehouse).to eq(warehouse)
    end

    it 'can belong to a user' do
      user = create(:user)
      power_bank = create(:power_bank, user: user)
      expect(power_bank.user).to eq(user)
    end
  end
end
