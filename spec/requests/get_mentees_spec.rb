require 'rails_helper'

describe 'GET /mentees', type: :request do
  before :each do
    @i_1 = Identity.create(title: 'parent')
    @user = User.create(background: 'a',cohort: 1810,program: "BE",first_name: "Jordan",last_name: "l")
    UserIdentity.create(user: @user, identity_id: @i_1.id)
    ContactDetails.create(email: "mail",phone:"2",slack:"@slack", user: @user)
    Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @user)

    @user_2 = User.create(background: 'a',cohort: 1811,program: "FE",first_name: "Jay",last_name: "l")
    UserIdentity.create(user: @user_2, identity_id: @i_1.id)
    ContactDetails.create(email: "mail",phone:"2",slack:"@slack", user: @user)
    Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @user)
  end

  context 'base route with no parameters' do
    it 'returns all mentee users' do
      get '/api/v1/mentees'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      mentee_json = JSON.parse(response.body)["data"]
      mentees = [@user, @user_2]

      expect(mentor_json.size).to eq(2)

      mentee_json.each_with_index do |json, i|
        expect(json).to have_key("id")
        expect(json["type"]).to eq("mentee")
        expect(json["first_name"]).to eq(mentees[i].first_name)
        expect(json["last_name"]).to eq(mentees[i].last_name)
        expect(json["cohort"]).to eq(mentees[i].cohort)
        expect(json["program"]).to eq(mentees[i].program)
        expect(json["background"]).to eq(mentees[i].background)
        expect(json["location"]).to eq(mentees[i].location)
        expect(json["attributes"]["mentor"]).to be_falsey
      end
    end
  end
end
