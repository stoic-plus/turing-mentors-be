require 'rails_helper'

describe 'PUT /mentors', type: :request do
  before :each do
    i_1 = Identity.create(title: 'female')
    @user = User.create(
      background: 'a',
      cohort: 1810,
      program: "BE",
      first_name: "Jordan",
      last_name: "l",
      current_job: "Mcdonalds",
      location: "Atlanta"
    )
    @ts_1 = TechSkill.create(title: 'javascript')
    @ts_2 = TechSkill.create(title: 'python')
    @nts_1 = NonTechSkill.create(title: 'stress management')
    @nts_2 = NonTechSkill.create(title: 'public speaking')
    UserIdentity.create(user: @user, identity_id: i_1.id)
    UserTechSkill.create(user: @user, tech_skill_id: @ts_1.id)
    UserNonTechSkill.create(user: @user, non_tech_skill_id: @nts_1.id)

    @contact = ContactDetails.create(email: "mail",phone:"2",slack:"@slack", user: @user)
    Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @user)
    Availability.create(day_of_week: 1, morning: true, afternoon: false, evening: false, user: @user)
    Availability.create(day_of_week: 2, morning: false, afternoon: true, evening: false, user: @user)
    Availability.create(day_of_week: 3, morning: false, afternoon: true, evening: true, user: @user)
    Availability.create(day_of_week: 4, morning: false, afternoon: true, evening: true, user: @user)
    Availability.create(day_of_week: 5, morning: false, afternoon: true, evening: true, user: @user)
    Availability.create(day_of_week: 6, morning: false, afternoon: true, evening: true, user: @user)
  end

  context 'with valid id, passing some attributes, adding to skills' do
    it 'returns the updated user' do
      user_contact = @user.contact_details
      expect(user_contact.phone).to eq(@contact.phone)
      expect(user_contact.slack).to eq(@contact.slack)
      expect(@user.tech_skills.count).to eq(1)
      expect(@user.non_tech_skills.count).to eq(1)
      updated = {
        phone: "510",
        slack: "@burgerzBoss",
        tech_skills: [@ts_2.id],
        non_tech_skills: [@nts_2.id],
        availability: {
          "0" => false,
          "1" => false,
          "2" => [true, false, false],
          "3" => [true, false, false],
          "4" => [true, false, false],
          "5" => [true, false, false],
          "6" => true
        }
      }

      return_availability = {
        "0" => [false, false, false],
        "1" => [false, false, false],
        "2" => [true, false, false],
        "3" => [true, false, false],
        "4" => [true, false, false],
        "5" => [true, false, false],
        "6" => [true, true, true]
      }

      put "/api/v1/mentors/#{@user.id}", params: updated

      expect(response.status).to eq(200)
      expect(response).to be_successful
      returned_user = JSON.parse(response.body)["data"]["attributes"]
      expect(returned_user["mentor"]).to be_truthy
      expect(returned_user["background"]).to eq(@user[:background])
      expect(returned_user["location"]).to eq(@user[:location])
      expect(returned_user["cohort"]).to eq(@user[:cohort])
      expect(returned_user["program"]).to eq(@user[:program])
      expect(returned_user["current_job"]).to eq(@user[:current_job])
      expect(returned_user["email"]).to eq(@user[:email])
      expect(returned_user["first_name"]).to eq(@user[:first_name])
      expect(returned_user["last_name"]).to eq(@user[:last_name])
      expect(returned_user["identities"]).to eq(@user.identities.pluck(:title))
      expect(returned_user["tech_skills"]).to eq([@ts_1.id, @ts_2.id])
      expect(returned_user["non_tech_skills"]).to eq([@nts_1.id, @nts_2.id])
      expect(returned_user["contact_details"]["phone"]).to eq(updated[:phone])
      expect(returned_user["contact_details"]["slack"]).to eq(updated[:slack])
      expect(returned_user["availability"]).to eq(return_availability)
    end
  end

  context 'with valid id and passing all attributes' do
    xit 'returns the updated user' do
      updated = {
        background: 'diff',
        cohort: 1811,
        program: "FE",
        email: "new_mail",
        first_name: "Jorge",
        identities: [@i_4.id,@i_5.id,@i_6.id],
        last_name: "a",
        phone: "8",
        slack: "@slackville",
        availability: {
          "0" => [true, true, true],
          "1" => [false, false, false],
          "2" => [true, true, true],
          "3" => [true, true, true],
          "4" => [true, true, true],
          "5" => [true, true, true],
          "6" => [true, true, true]
        }
      }

      put "/api/v1/mentees/#{@user.id}", params: updated

      expect(response.status).to eq(200)
      expect(response).to be_successful
      returned_user = JSON.parse(response.body)["data"]["attributes"]

      expect(returned_user["background"]).to eq(updated[:background])
      expect(returned_user["cohort"]).to eq(updated[:cohort])
      expect(returned_user["program"]).to eq(updated[:program])
      expect(returned_user["contact_details"]["email"]).to eq(updated[:email])
      expect(returned_user["first_name"]).to eq(updated[:first_name])
      expect(returned_user["identities"]).to eq(Identity.pluck(:title))
      expect(returned_user["last_name"]).to eq(updated[:last_name])
      expect(returned_user["contact_details"]["phone"]).to eq(updated[:phone])
      expect(returned_user["contact_details"]["slack"]).to eq(updated[:slack])
      expect(returned_user["availability"]).to eq(updated[:availability])
    end
  end

  context 'with invalid user id' do
    xit 'returns 404 status code' do
      updated = {
        phone: "510",
        slack: "@burgerzBoss",
        availability: {
          0 => [false, false, false],
          1 => false,
          2 => [false, false, false],
          3 => [false, false, false],
          4 => [false, false, false],
          5 => [false, false, false],
          6 => [false, false, false]
        }
      }

      put "/api/v1/mentees/12", params: updated

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to eq({"message" => "mentee not found by that id"})
    end
  end
end
