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
         "0": [false,true,false],
         "1": [false,false,false],
         "2": [false,true,false],
         "3": [false,false,false],
         "4": [false,false,false],
         "5": [false,false,false],
         "6": [false,false,false]
        }
        Availability.for_user(availability, user)

        expect(user.availabilities.count).to eq(7)
        user.availabilities.each_with_index do |availability|
          binding.pry
          expect(availability.morning).to eq()
        end
      end
    end
  end
end
