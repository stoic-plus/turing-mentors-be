require 'rails_helper'

describe 'GET /mentees/:id', type: :request do
  before :each do
    i_2 = Identity.create(title: 'parent')
    @in_1 = Interest.create(title: 'rock climbing')
    @in_2 = Interest.create(title: 'skating')
    @user = User.create(
      background: 'a',
      cohort: 1810,
      program: "BE",
      first_name: "Jordan",
      last_name: "l",
    )
    UserIdentity.create(user: @user, identity_id: i_2.id)
    UserInterest.create(interest_id: @in_1.id, user: @user)
    UserInterest.create(interest_id: @in_2.id, user: @user)
    @contact = ContactDetails.create(email: "mail",phone:"2",slack:"@slack", user: @user)
    Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @user)
    Availability.create(day_of_week: 1, morning: true, afternoon: false, evening: false, user: @user)
  end

  context 'passing a valid id' do
    it 'does not return user if user is a mentor' do
      user = User.create(
        background: 'a',
        cohort: 1810,
        program: "BE",
        first_name: "Jordan",
        last_name: "l",
        current_job: "Mcdonalds",
        city: "Atlanta",
        state: "TX",
        mentor: true
      )
      i_1 = Identity.create(title: 'male')
      ts_1 = TechSkill.create(title: 'javascript')
      nts_1 = NonTechSkill.create(title: 'stress management')
      UserIdentity.create(user: @user, identity_id: i_1.id)
      UserTechSkill.create(user: @user, tech_skill_id: ts_1.id)
      UserNonTechSkill.create(user: @user, non_tech_skill_id: nts_1.id)
      ContactDetails.create(email: "mail",phone:"2",slack:"@slack", user: user)
      Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: user)


      get "/api/v1/mentees/#{user.id}"

      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to eq({"message" => "mentee not found by that id"})
    end

    it 'returns the mentee user' do
      availability = {
        "0" => [false, false, true],
        "1" => [true, false, false]
      }

      get "/api/v1/mentees/#{@user.id}"

      expect(response.status).to eq(200)
      expect(response).to be_successful
      returned_user = JSON.parse(response.body)["data"]["attributes"]

      expect(returned_user["background"]).to eq(@user.background)
      expect(returned_user["cohort"]).to eq(@user.cohort)
      expect(returned_user["program"]).to eq(@user.program)
      expect(returned_user["contact_details"]["email"]).to eq(@contact.email)
      expect(returned_user["first_name"]).to eq(@user.first_name)
      expect(returned_user["identities"]).to eq(Identity.pluck(:title))
      expect(returned_user["interests"]).to eq(Interest.pluck(:title))
      expect(returned_user["last_name"]).to eq(@user.last_name)
      expect(returned_user["contact_details"]["phone"]).to eq(@contact.phone)
      expect(returned_user["contact_details"]["slack"]).to eq(@contact.slack)
      expect(returned_user["availability"]).to eq(availability)
    end
  end

  context 'passing an invalid id' do
    it 'returns 404 status code' do
      get "/api/v1/mentees/12"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to eq({"message" => "mentee not found by that id"})
    end
  end
end
