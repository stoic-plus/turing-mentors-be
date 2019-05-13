require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:current_job)}
    it {should validate_presence_of(:background)}
  end

  describe 'relationships' do
    it {should have_one(:contact_details)}
    it {should have_many(:user_identities)}
    it {should have_many(:identities).through(:user_identities)}
    it {should have_many(:user_tech_skills)}
    it {should have_many(:tech_skills).through(:user_tech_skills)}
    it {should have_many(:user_non_tech_skills)}
    it {should have_many(:non_tech_skills).through(:user_non_tech_skills)}
    it {should have_many(:user_interests)}
    it {should have_many(:interests).through(:user_interests)}
  end

  describe 'scopes' do
    before :each do
      @t_1 = TechSkill.create(title: 'Javascript')
      @t_2 = TechSkill.create(title: 'Ruby')

      @u_1 = User.create(first_name: 'Travis', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: true, city: 'Denver', state: 'CO')
      UserTechSkill.create(user_id: @u_1.id, tech_skill_id: @t_2.id)

      @u_2 = User.create(first_name: 'Ben', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: false, city: 'Denver', state: 'CO')
      UserTechSkill.create(user_id: @u_2.id, tech_skill_id: @t_1.id)

      @u_3 = User.create(first_name: 'Frank', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: true, city: 'New York', state: 'NY')
      UserTechSkill.create(user_id: @u_3.id, tech_skill_id: @t_1.id)
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

    context '.mentors.and_tech_skills' do
      it 'returns joins table of those' do
        joins = User.mentors.and_tech_skills
        expect(joins.size).to eq(2)
        expect(joins.first.first_name).to eq("Travis")
        expect(joins.first.last_name).to eq("Gee")
        expect(joins.first.mentor).to be_truthy
        expect(joins.first.tech_skills.size).to eq(1)
        expect(joins.first.tech_skills.first.title).to eq("Ruby")

        expect(joins.second.first_name).to eq(@u_3.first_name)
        expect(joins.second.last_name).to eq(@u_3.last_name)
        expect(joins.second.mentor).to be_truthy
        expect(joins.second.tech_skills.size).to eq(1)
        expect(joins.second.tech_skills.first.title).to eq("Javascript")
      end
    end

    context '.tech_skilled_in' do
      it 'returns users where tech_skills includes passed languages' do
        skilled_in_r = User.tech_skilled_in('Ruby')

        expect(skilled_in_r.size).to eq(1)
        expect(skilled_in_r.first.first_name).to eq("Travis")
        expect(skilled_in_r.first.tech_skills.size).to eq(1)
        expect(skilled_in_r.first.tech_skills.first.title).to eq("Ruby")

        skilled_in_j = User.tech_skilled_in('Javascript')

        expect(skilled_in_j.size).to eq(2)
        expect(skilled_in_j.first.first_name).to eq("Ben")
        expect(skilled_in_j.second.first_name).to eq("Frank")
        expect(skilled_in_j.first.tech_skills.size).to eq(1)
        expect(skilled_in_j.second.tech_skills.size).to eq(1)
        expect(skilled_in_j.first.tech_skills.first.title).to eq("Javascript")
        expect(skilled_in_j.second.tech_skills.first.title).to eq("Javascript")
      end
    end
  end

  describe 'class methods' do
    context 'new_mentor' do
      it 'creates a mentor user (using new not create) given hash of attributes' do
        mentor_attr = {
          first_name: 'first',
          last_name: 'last',
          city: 'TAHITI',
          state: "TX",
          current_job: 'google',
          cohort: 1810,
          program: 'BE',
          background: 'add it here'
        }
        mentor = User.new_mentor(mentor_attr)

        expect(mentor.mentor).to be_truthy
        expect(mentor.first_name).to eq(mentor_attr[:first_name])
        expect(mentor.last_name).to eq(mentor_attr[:last_name])
        expect(mentor.city).to eq(mentor_attr[:city])
        expect(mentor.state).to eq(mentor_attr[:state])
        expect(mentor.current_job).to eq(mentor_attr[:current_job])
        expect(mentor.cohort).to eq(mentor_attr[:cohort])
        expect(mentor.program).to eq(mentor_attr[:program])
        expect(mentor.background).to eq(mentor_attr[:background])
      end
    end
  end

  describe 'instance methods' do
    context '#list_skills(:tech)' do
       it 'returns array of tech_skills this user has' do
        t_3 = TechSkill.create(title: 'Elixir')
        t_4 = TechSkill.create(title: 'Java')

        user = User.create(first_name: 'Travis', last_name: 'Bee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: true, city: 'Denver', state: 'CO')
        UserTechSkill.create(user_id: user.id, tech_skill_id: t_3.id)
        UserTechSkill.create(user_id: user.id, tech_skill_id: t_4.id)

        actual = user.list_skills(:tech)
        expected = ['Elixir', 'Java']

        expect(actual).to eq(expected)
      end
    end

    context '#list_availability' do
      it 'returns hash with day_of_week keys and time_of_day array value' do
        user = User.create(first_name: 'Travis', last_name: 'Bee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: true, city: 'Denver', state: 'CO')
        Availability.create(day_of_week: 0, morning: false, afternoon: true, evening: false, user: user)
        Availability.create(day_of_week: 1, morning: true, afternoon: true, evening: false, user: user)

        actual = user.list_availability
        expected = {
          0 => [false, true, false],
          1 => [true, true, false]
        }
        expect(actual).to eq(expected)
      end
    end

    context '#list_identities' do
      it 'returns array of identity names' do
        identity = Identity.create(title: "parent")
        identity_2 = Identity.create(title: "basketball person")
        user = User.create(first_name: 'Travis', last_name: 'Bee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: true, city: 'Denver', state: 'CO')
        user.identities << identity
        user.identities << identity_2
        actual = user.list_identities
        expected = ["parent", "basketball person"]

        expect(actual).to eq(expected)
      end
    end

    context '#list_interests' do
      it 'returns array of interest names' do
        interest = Interest.create(title: "games")
        interest_2 = Interest.create(title: "basketball")
        user = User.create(first_name: 'Travis', last_name: 'Bee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: true, city: 'Denver', state: 'CO')
        user.interests << interest
        user.interests << interest_2
        actual = user.list_interests
        expected = [interest.title, interest_2.title]

        expect(actual).to eq(expected)
      end
    end

    context '#list_contact_details' do
      it 'returns a hash with contact type as key and string as value' do
        user = User.create(first_name: 'Travis', last_name: 'Bee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: true, city: 'Denver', state: 'CO')
        ContactDetails.create({
          email: "email",
          slack: "@slack",
          phone: "720",
          user: user
        })

        expected = {
          email: "email",
          slack: "@slack",
          phone: "720"
        }
        actual = user.list_contact_details

        expect(actual).to eq(expected)
      end
    end
  end
end
