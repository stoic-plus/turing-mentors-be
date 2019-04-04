require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:active)}
    it {should validate_presence_of(:current_job)}
    it {should validate_presence_of(:background)}
    it {should validate_presence_of(:location)}
  end

  describe 'relationships' do
    it {should have_one(:contact_details)}
    it {should have_many(:user_identities)}
    it {should have_many(:identities).through(:user_identities)}
    it {should have_many(:user_tech_skills)}
    it {should have_many(:tech_skills).through(:user_tech_skills)}
    it {should have_many(:user_non_tech_skills)}
    it {should have_many(:non_tech_skills).through(:user_non_tech_skills)}
  end

  describe 'scopes' do
    before :each do
      @u_1 = User.create(name: 'Travis Gee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: true, location: 'Denver, CO')
      @u_2 = User.create(name: 'Ben Gee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: false, location: 'Denver, CO')
      @u_3 = User.create(name: 'Frank Gee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: true, location: 'New York, NY')
    end

    context '.mentors' do
      it 'returns mentor users' do
        actual = User.mentors
        expected = [@u_1, @u_3]
        expect(actual).to eq(expected)
      end
    end

    context '.denver_mentors' do
      it 'returns mentor users who are located in denver' do
        actual = User.denver_mentors
        expected = [@u_1]

        expect(actual).to eq(expected)
      end
    end

    context '.remote_mentors' do
      it 'returns mentor users who are not in denver' do
        actual = User.remote_mentors
        expected = [@u_3]

        expect(actual).to eq(expected)
      end
    end
  end

  describe 'instance methods' do

  end
end
