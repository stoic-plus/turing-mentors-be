require 'rails_helper'

describe ContactDetails, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:preferred_method)}
  end

  describe 'class methods' do
  end
end
