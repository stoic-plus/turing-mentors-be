require 'rails_helper'

describe 'POST /mentors', type: :request do
  before :each do
    @user = {
      background: "...",
      cohort: 1810,
      program: "BE",
      email: "j@mail.com",
      firstName: "j",
      tech_skills: [0, 1, 3],
      identities: [0],
      lastName: "l",
      phone: "720",
      slack: "@slack",
      timeFri: [true, false, true],
      timeMon: true,
      timeSat: [true, false, false],
      timeSun: [true, false, true],
      timeThu: [false, false, true],
      timeTue: [true, false, true],
      timeWed: [true, false, false]
    }
  end

  context 'passing all neccesary attributes' do
    User.create(name: 'Travis Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
    it 'returns the created mentor' do
      post '/api/v1/mentors', params: @user

      expect(User.count).to eq(2)
      tech_skills = TechSkill.where(id: @user[:tech_skills]).pluck(:title)
      identities = Identity.where(id: @user[:identities]).pluck(:title)
      created_user = JSON.parse(response.body)["data"]["attributes"]

      expect(created_user["name"]).to eq("#{@user["firstName"]} #{@user["lastName"]}")
      expect(created_user["cohort"]).to eq(@user)
      expect(created_user["program"]).to eq(@user)
      expect(created_user).to have_key("current_job")
      expect(created_user["background"]).to eq(@user)
      expect(created_user["mentor"]).to be_truthy
      expect(created_user["location"]).to eq(@user["location"])
      expect(created_user["tech_skills"]).to eq(tech_skills)
      expect(created_user["identities"]).to eq(identities)
      expect(created_user["contact_details"]).to eq({
        email: @user[:email],
        phone: @user[:phone],
        slack: @user[:slack]
      })
      expect(created_user["availability"]).to eq({
        timeFri: @user[:timeFri],
        timeMon: @user[:timeMon],
        timeSat: @user[:timeSat],
        timeSun: @user[:timeSun],
        timeThu: @user[:timeThu],
        timeTue: @user[:timeTue],
        timeWed: @user[:timeWed]
      })
      expect(response).to be_successful
    end
  end
end
