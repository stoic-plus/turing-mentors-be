require 'rails_helper'

describe 'PUT /mentees', type: :request do
  before :each do
    i_1 = Identity.create(title: 'male')
    i_2 = Identity.create(title: 'parent')
    i_3 = Identity.create(title: 'pianist')
    @i_4 = Identity.create(title: 'biker')
    @i_5 = Identity.create(title: 'surfer')
    @i_6 = Identity.create(title: 'renegade')
    @user = User.create(
      background: 'a',
      cohort: 1810,
      program: "BE",
      first_name: "Jordan",
      last_name: "l",
    )
    UserIdentity.create(user: @user, identity_id: i_1.id)
    UserIdentity.create(user: @user, identity_id: i_2.id)
    UserIdentity.create(user: @user, identity_id: i_3.id)

    @contact = ContactDetails.create(email: "mail",phone:"2",slack:"@slack", user: @user)
    Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @user)
    Availability.create(day_of_week: 1, morning: true, afternoon: false, evening: false, user: @user)
    Availability.create(day_of_week: 2, morning: false, afternoon: true, evening: false, user: @user)
    Availability.create(day_of_week: 3, morning: false, afternoon: true, evening: true, user: @user)
    Availability.create(day_of_week: 4, morning: false, afternoon: true, evening: true, user: @user)
    Availability.create(day_of_week: 5, morning: false, afternoon: true, evening: true, user: @user)
    Availability.create(day_of_week: 6, morning: false, afternoon: true, evening: true, user: @user)
  end

  context 'with valid id and passing some attributes' do
    it 'returns the updated user' do
      updated = {
        phone: "510",
        slack: "@burgerzBoss",
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

      put "/api/v1/mentees/#{@user.id}", params: updated

      expect(response.status).to eq(200)
      expect(response).to be_successful
      returned_user = JSON.parse(response.body)["data"]["attributes"]
      expect(returned_user["background"]).to eq(@user[:background])
      expect(returned_user["cohort"]).to eq(@user[:cohort])
      expect(returned_user["program"]).to eq(@user[:program])
      expect(returned_user["email"]).to eq(@user[:email])
      expect(returned_user["first_name"]).to eq(@user[:first_name])
      expect(returned_user["identities"]).to eq(@user.identities.pluck(:title))
      expect(returned_user["last_name"]).to eq(@user[:last_name])
      expect(returned_user["contact_details"]["phone"]).to eq(updated[:phone])
      expect(returned_user["contact_details"]["slack"]).to eq(updated[:slack])
      expect(returned_user["availability"]).to eq(return_availability)
    end
  end

  context 'with valid id and passing all attributes' do
    it 'returns the updated user' do
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
    it 'returns 404 status code' do
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
