require 'rails_helper'

describe 'POST /mentors', type: :request do
  before :each do
    Identity.create(title: 'male')
    @user = {
      background: "...",
      cohort: 1810,
      program: "BE",
      current_job: "Ibotta",
      email: "j@mail.com",
      first_name: "j",
      tech_skills: [0, 1, 3],
      identities: [1],
      last_name: "l",
      phone: "720",
      slack: "@slack",
      availability: {
        0 => [true, false, true],
        1 => true,
        2 => [true, false, false],
        3 => [true, false, true],
        4 => [false, false, true],
        5 => [true, false, true],
        6 => [true, false, false]
      }

    }
  end

  context 'passing all neccesary attributes' do
    it 'returns the created mentor' do
      expect(User.count).to eq(0)
      post '/api/v1/mentors', params: @user

      expect(User.count).to eq(1)
      tech_skills = TechSkill.where(id: @user[:tech_skills]).pluck(:title)
      identities = Identity.where(id: @user[:identities]).pluck(:title)
      created_user = JSON.parse(response.body)["data"]["attributes"]

      expect(created_user["first_name"]).to eq(@user[:first_name])
      expect(created_user["last_name"]).to eq(@user[:last_name])
      expect(created_user["cohort"]).to eq(@user[:cohort])
      expect(created_user["program"]).to eq(@user[:program])
      expect(created_user).to have_key("current_job")
      expect(created_user["background"]).to eq(@user[:background])
      expect(created_user["mentor"]).to be_truthy
      expect(created_user["tech_skills"]).to eq(tech_skills)
      expect(created_user["identities"]).to eq(identities)
      expect(created_user["contact_details"]).to eq({
        "email" => @user[:email],
        "phone" => @user[:phone],
        "slack" => @user[:slack]
      })
      expect(created_user["availability"]).to eq({
        "0" => @user[:availability][0],
        "1" => [true,true,true],
        "2" => @user[:availability][2],
        "3" => @user[:availability][3],
        "4" => @user[:availability][4],
        "5" => @user[:availability][5],
        "6" => @user[:availability][6]
      })
      expect(response).to be_successful
    end
  end
end
