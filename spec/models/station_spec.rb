require 'rails_helper'

RSpec.describe Station, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      station = build(:station)
      expect(station).to be_valid
    end

    it 'is not valid without a name' do
      station = build(:station, name: nil)
      expect(station).not_to be_valid
      expect(station.errors[:name]).to include("can't be blank")
    end

    it 'status is by default online' do
      station = build(:station, status: nil)
      expect(station).not_to eq('online')
    end
  end

  describe 'associations' do
    it 'can have multiple power banks' do
      station = create(:station)
      power_bank1 = create(:power_bank, station: station)
      power_bank2 = create(:power_bank, station: station)
      expect(station.power_banks).to include(power_bank1, power_bank2)
    end

    it 'can belong to a location' do
      location = create(:location)
      station = create(:station, location: location)
      expect(station.location).to eq(location)
    end
  end
end
