require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it "is valid with valid attributes" do
      user = create(:user)
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is not valid without a password' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: 'test@email.com')
      user = build(:user, email: "test@email.com")
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('has already been taken')
    end

    it "is not valid without a password matching" do
      user = build(:user, password_confirmation: "password1")
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  describe 'isAdmin' do
    it 'isAdmin as default isn\'t admin' do
      user = build(:user)
      expect(user.isAdmin).to_not eq('admin')
    end

    it 'isAdmin as default is user' do
      user = build(:user)
      expect(user.isAdmin).to eq('user')
    end
  end

  describe 'authentication' do
    it 'authenticates with a valid password' do
      user = create(:user)
      expect(user.authenticate('password')).to be_truthy
    end

    it 'does not authenticate with an invalid password' do
      user = create(:user, password: 'password')
      expect(user.authenticate('invalid')).to be_falsey
    end
  end

  describe 'associations' do
    it 'can have multiple power banks' do
      user = create(:user)
      power_bank1 = create(:power_bank, user: user)
      power_bank2 = create(:power_bank, user: user)
      expect(user.power_banks).to include(power_bank1, power_bank2)
    end
  end
end
