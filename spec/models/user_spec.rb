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
      @t_1 = TechSkill.create(title: 'Javascript')
      @t_2 = TechSkill.create(title: 'Ruby')

      @u_1 = User.create(name: 'Travis Gee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: true, location: 'Denver, CO')
      UserTechSkill.create(user_id: @u_1.id, tech_skill_id: @t_2.id)

      @u_2 = User.create(name: 'Ben Gee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: false, location: 'Denver, CO')
      UserTechSkill.create(user_id: @u_2.id, tech_skill_id: @t_1.id)

      @u_3 = User.create(name: 'Frank Gee', cohort: 1810, program: 'FE', current_job: 'graduate', background: 'IT', mentor: true, location: 'New York, NY')
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

    context '.mentors_and_skills' do
      it 'returns joins table of those' do
        joins = User.mentors_and_skills
        expect(joins.size).to eq(2)
        expect(joins.first.name).to eq("Travis Gee")
        expect(joins.first.mentor).to be_truthy
        expect(joins.first.tech_skills.size).to eq(1)
        expect(joins.first.tech_skills.first.title).to eq("Ruby")

        expect(joins.second.name).to eq("Frank Gee")
        expect(joins.second.mentor).to be_truthy
        expect(joins.second.tech_skills.size).to eq(1)
        expect(joins.second.tech_skills.first.title).to eq("Javascript")
      end
    end

    context '.tech_skilled_in' do
      it 'returns mentors where tech_skills includes passed languages' do
        skilled_in_r = User.tech_skilled_in('Ruby')

        expect(skilled_in_r.size).to eq(1)
        expect(skilled_in_r.first.mentor).to be_truthy
        expect(skilled_in_r.first.name).to eq("Travis Gee")
        expect(skilled_in_r.first.tech_skills.size).to eq(1)
        expect(skilled_in_r.first.tech_skills.first.title).to eq("Ruby")

        skilled_in_j = User.tech_skilled_in('Javascript')

        expect(skilled_in_j.size).to eq(1)
        expect(skilled_in_j.first.mentor).to be_truthy
        expect(skilled_in_j.first.name).to eq("Frank Gee")
        expect(skilled_in_j.first.tech_skills.size).to eq(1)
        expect(skilled_in_j.first.tech_skills.first.title).to eq("Javascript")
      end
    end
  end

  describe 'instance methods' do

  end
end
