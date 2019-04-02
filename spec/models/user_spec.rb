require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:active)}
    it {should validate_presence_of(:current_job)}
    it {should validate_presence_of(:background)}
    it {should validate_presence_of(:location)}
    it {should validate_presence_of(:mentor)}
  end

  describe 'relationships' do
    it {should have_many(:contact_details)}
    it {should have_many(:identities).through(:user_identities)}
    it {should have_many(:tech_skills).through(:user_tech_skills)}
    it {should have_many(:nontech_skills).through(:user_nontech_skills)}
  end

  describe 'class methods' do

  end

  describe 'instance methods' do

  end
end
