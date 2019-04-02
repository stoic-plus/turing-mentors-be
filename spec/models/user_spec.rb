require 'rails_helper'

describe User, type: :model do
  context 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:current_job)}
    it {should validate_presence_of(:background)}
    it {should validate_presence_of(:location)}
    it {should validate_presence_of(:mentor)}
    it {should have_many(:locations)}
    it {should have_many(:contact_details)}
    it {should have_many(:tech_skills).through(:user_tech_skills)}
    it {should have_many(:nontech_skills).through(:user_nontech_skills)}
  end

  context 'class methods' do

  end

  context 'instance methods' do

  end
end
