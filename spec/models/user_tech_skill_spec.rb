require 'rails_helper'

describe UserTechSkill, type: :model do
  describe 'class methods' do
    context 'for_user' do
      it 'creates tech skills for a user given array of tech_skill id\'s and a user' do
        ts_1 = TechSkill.create(title: 'js')
        ts_2 = TechSkill.create(title: 'ruby')
        ts_3 = TechSkill.create(title: 'machine learning')
        user = User.create(first_name: 'Travis', last_name: ' Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
        UserTechSkill.for_user([1, 2, 3], user)

        actual = user.tech_skills
        expect(actual.count).to eq(3)
        expect(actual.first).to eq(ts_1)
        expect(actual.second).to eq(ts_2)
        expect(actual.third).to eq(ts_3)
      end
    end
  end
end
