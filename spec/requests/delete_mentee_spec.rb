require 'rails_helper'

describe 'DELETE /mentees', type: :request do
  before :each do
    i_1 = Identity.create(title: 'male')
    @user = User.create(
      background: 'a',
      cohort: 1810,
      program: "BE",
      first_name: "Jordan",
      last_name: "l",
      mentor: false
    )
    UserIdentity.create(user: @user, identity_id: i_1.id)
    ContactDetails.create(email: "mail",phone:"2",slack:"@slack", user: @user)
    Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @user)
  end

  context 'passing valid id' do
    it 'does not remove user if found user is a mentor' do
      user = User.create(
        background: 'a',
        cohort: 1810,
        program: "BE",
        first_name: "Jordan",
        last_name: "l",
        current_job: "Mcdonalds",
        location: "Atlanta",
        mentor: true
      )
      TechSkill.create(title: 'javascript')
      NonTechSkill.create(title: 'stress management')
      UserIdentity.create(user: @user, identity_id: @i_1.id)
      UserTechSkill.create(user: @user, tech_skill_id: @ts_1.id)
      UserNonTechSkill.create(user: @user, non_tech_skill_id: @nts_1.id)
      ContactDetails.create(email: "mail",phone:"2",slack:"@slack", user: @user)
      Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @user)

      expect(User.count).to eq(2)
      expect(UserIdentity.count).to eq(2)
      expect(ContactDetails.count).to eq(2)
      expect(Availability.count).to eq(2)
      expect(UserTechSkill.count).to eq(1)
      expect(UserNonTechSkill.count).to eq(1)

      delete "/api/v1/mentees/#{user.id}"

      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to eq({"message" => "mentee not found by that id"})

      expect(User.count).to eq(2)
      expect(UserIdentity.count).to eq(2)
      expect(ContactDetails.count).to eq(2)
      expect(Availability.count).to eq(2)
      expect(UserTechSkill.count).to eq(1)
      expect(UserNonTechSkill.count).to eq(1)
    end

    it 'removes the user and all entries in supporting tables' do
      expect(User.count).to eq(1)
      expect(UserIdentity.count).to eq(1)
      expect(ContactDetails.count).to eq(1)
      expect(Availability.count).to eq(1)

      delete "/api/v1/mentees/#{@user.id}"

      expect(response.status).to eq(204)
      expect(response).to be_successful

      expect(User.count).to eq(0)
      expect(UserIdentity.count).to eq(0)
      expect(ContactDetails.count).to eq(0)
      expect(Availability.count).to eq(0)
    end
  end

  context 'passing invalid id' do
    it 'returns 404 status code' do
      delete "/api/v1/mentees/12"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to eq({"message" => "mentee not found by that id"})
    end
  end
end
