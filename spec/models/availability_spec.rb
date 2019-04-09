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
    context '.for_user' do
      it 'creates availability for user given hash of day of week (int) keys and time of day values ([false, true, false]) and a user' do
        user = User.create(first_name: 'Travis', last_name: ' Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
        user_availability = {
         "0" => [false,true,false],
         "1" => [false,true,true],
         "2" => [false,true,false],
         "3" => [false,false,false],
         "4" => [true,false,false],
         "5" => [false,true,false],
         "6" => [false,false,true]
        }
        Availability.for_user(user_availability, user)
        expect(user.availabilities.count).to eq(7)
        user.availabilities.each_with_index do |availability, index|
          expect(availability.morning).to eq(user_availability[index.to_s].first)
          expect(availability.afternoon).to eq(user_availability[index.to_s].second)
          expect(availability.evening).to eq(user_availability[index.to_s].third)
        end
      end
    end
  end
end
