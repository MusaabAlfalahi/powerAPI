require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      warehouse = build(:warehouse)
      expect(warehouse).to be_valid
    end

    it 'is not valid without a name' do
      warehouse = build(:warehouse, name: nil)
      expect(warehouse).not_to be_valid
    end
  end

  describe 'associations' do
    it 'can have multiple stations' do
      warehouse = create(:warehouse)
      station1 = create(:station, warehouse: warehouse)
      station2 = create(:station, warehouse: warehouse)
      expect(warehouse.stations).to include(station1, station2)
    end

    it 'can have multiple power banks' do
      warehouse = create(:warehouse)
      power_bank1 = create(:power_bank, warehouse: warehouse)
      power_bank2 = create(:power_bank, warehouse: warehouse)
      expect(warehouse.power_banks).to include(power_bank1, power_bank2)
    end
  end
end
