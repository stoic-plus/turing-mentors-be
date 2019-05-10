require 'rails_helper'

describe Availability, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:day_of_week)}
    it {should validate_inclusion_of(:morning).in_array([true, false])}
    it {should validate_inclusion_of(:afternoon).in_array([true, false])}
    it {should validate_inclusion_of(:evening).in_array([true, false])}
  end

  describe 'relationships' do
    it {should belong_to(:user)}
  end

  describe 'class methods' do
  end
end
