require 'rails_helper'

describe 'POST /mentees', type: :request do
  before :each do
    Identity.create(title: 'male')
    Identity.create(title: 'parent')
    Identity.create(title: 'BOSS')
    @user = {
      background: "...",
      cohort: 1810,
      program: "BE",
      email: "j@mail.com",
      first_name: "j",
      identities: [1, 2, 3],
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
    it 'returns the created mentee' do
      expect(User.count).to eq(0)
      post '/api/v1/mentees', params: @user

      identities = Identity.where(id: @user[:identities]).pluck(:title)
      created_user = JSON.parse(response.body)["data"]["attributes"]
      expect(created_user["first_name"]).to eq(@user[:first_name])
      expect(created_user["last_name"]).to eq(@user[:last_name])
      expect(created_user["cohort"]).to eq(@user[:cohort])
      expect(created_user["program"]).to eq(@user[:program])
      expect(created_user["background"]).to eq(@user[:background])
      expect(created_user["mentor"]).to be_falsey
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
      expect(response.status).to eq(200)
    end

    xit 'creates neccesary rows in supporting tables for the created user' do
      expect(User.count).to eq(0)
      post '/api/v1/mentees', params: @user

      expect(User.count).to eq(1)
      expect(ContactDetails.count).to eq(1)
      expect(UserIdentity.count).to eq(3)
      expect(Availability.count).to eq(7)
    end

    it 'returns error if not all user params are sent' do
      user = {
        background: "...",
        cohort: 1810,
        program: "BE",
        current_job: "Ibotta",
        email: "j@mail.com",
        first_name: "j",
      }

      post '/api/v1/mentees', params: user

      expect(response.status).to eq(400)
      expect(response).to_not be_successful
      expect(JSON.parse(response.body)).to eq({"message" => "incorrect user information supplied"})
    end
  end
end
