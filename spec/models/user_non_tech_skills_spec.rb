require 'rails_helper'

describe UserNonTechSkill, type: :model do
  describe 'class methods' do
    context 'for_user' do
      it 'creates non tech skills for a user given array of non tech_skill id\'s and a user' do
        nts_1 = NonTechSkill.create(title: 'massage')
        nts_2 = NonTechSkill.create(title: 'jumping')
        nts_3 = NonTechSkill.create(title: 'machine')
        user = User.create(first_name: 'Travis', last_name: ' Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
        UserNonTechSkill.for_user([1, 2, 3], user)

        actual = user.non_tech_skills
        expect(actual.count).to eq(3)
        expect(actual.first).to eq(nts_1)
        expect(actual.second).to eq(nts_2)
        expect(actual.third).to eq(nts_3)
      end
    end
  end
end
