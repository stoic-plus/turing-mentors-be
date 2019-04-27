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
    @contact = ContactDetails.create(email: "mail",phone:"2",slack:"@slack", user: @user_2)
    @availability = Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @user_2)
  end

  context 'base route with no parameters' do
    it 'returns all mentee users' do
      get '/api/v1/mentees'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      mentee_json = JSON.parse(response.body)["data"]
      mentees = [@user, @user_2]

      expect(mentee_json.size).to eq(2)

      mentee_json.each_with_index do |json, i|
        expect(json).to have_key("id")
        expect(json["type"]).to eq("mentee")
        expect(json["attributes"]["first_name"]).to eq(mentees[i].first_name)
        expect(json["attributes"]["last_name"]).to eq(mentees[i].last_name)
        expect(json["attributes"]["cohort"]).to eq(mentees[i].cohort)
        expect(json["attributes"]["program"]).to eq(mentees[i].program)
        expect(json["attributes"]["background"]).to eq(mentees[i].background)
        expect(json["attributes"]["mentor"]).to be_falsey
        expect(json["attributes"]["availability"].first.first.to_i).to eq(@availability.day_of_week)
        expect(json["attributes"]["availability"].first.second.first).to eq(@availability.morning)
        expect(json["attributes"]["availability"].first.second.second).to eq(@availability.afternoon)
        expect(json["attributes"]["availability"].first.second.third).to eq(@availability.evening)
        expect(json["attributes"]["identities"]).to eq([@i_1.title])
        expect(json["attributes"]["contact_details"]["email"]).to eq(@contact.email)
        expect(json["attributes"]["contact_details"]["slack"]).to eq(@contact.slack)
        expect(json["attributes"]["contact_details"]["phone"]).to eq(@contact.phone)
      end
    end
  end
end
