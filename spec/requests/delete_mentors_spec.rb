require 'rails_helper'

describe 'DELETE /mentors', type: :request do
  before :each do
    i_1 = Identity.create(title: 'male')
    @user = User.create(
      background: 'a',
      cohort: 1810,
      program: "BE",
      first_name: "Jordan",
      last_name: "l",
    )
    UserIdentity.create(user: @user, identity_id: i_1.id)
    ContactDetails.create(email: "mail",phone:"2",slack:"@slack", user: @user)
    Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @user)
  end

  context 'passing valid id' do
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
