require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      location = build(:location)
      expect(location).to be_valid
    end

    it 'is not valid without a name' do
      location = build(:location, name: nil)
      expect(location).not_to be_valid
      expect(location.errors[:name]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'can have multiple stations' do
      location = create(:location)
      station1 = create(:station, location: location)
      station2 = create(:station, location: location)
      expect(location.stations).to include(station1, station2)
    end
  end
end
