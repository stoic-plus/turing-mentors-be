require 'rails_helper'

describe UserIdentity, type: :model do
  describe 'class methods' do
    context 'for_user' do
      it 'creates identities for a user given array of identity id\'s and a user' do
        id_1 = UserIdentity.create(title: 'male')
        id_2 = UserIdentity.create(title: 'parent')
        id_3 = UserIdentity.create(title: 'trucker')
        user = User.create(first_name: 'Travis', last_name: ' Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
        UserIdentity.for_user([1, 2, 3], user)

        actual = user.identities
        expect(actual.count).to eq(3)
        expect(actual.first).to eq(id_1)
        expect(actual.second).to eq(id_2)
        expect(actual.third).to eq(id_3)
      end
    end
  end
end
