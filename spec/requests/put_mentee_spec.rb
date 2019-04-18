require 'rails_helper'

describe 'PUT /mentees', type: :request do
  before :each do
    @user = User.create(
      background: 'a',
      cohort: 1810,
      program: "BE",
      email: "mail",
      first_name: "Jordan",
      identities: [1,2,3],
      last_name: "l",
      phone: "2",
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
    )
  end

  context 'with valid id and passing some attributes' do
    it 'returns the updated user' do
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

      put "/api/v1/mentees/#{@user.id}", params: updated

      expect(response.status).to eq(200)
      expect(response).to be_successful
      returned_user = JSON.parse(response.body)["data"]["attributes"]

      expect(returned_user[background]).to eq(@user[:background])
      expect(returned_user[cohort]).to eq(@user[:cohort])
      expect(returned_user[program]).to eq(@user[:program])
      expect(returned_user[email]).to eq(@user[:email])
      expect(returned_user[first_name]).to eq(@user[:first_name])
      expect(returned_user[identities]).to eq(@user[:identities])
      expect(returned_user[last_name]).to eq(@user[:last_name])
      expect(returned_user[phone]).to eq(updated[:phone])
      expect(returned_user[slack]).to eq(updated[:slack])
      expect(returned_user[availability]).to eq(updated[:availability])
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
        identities: [4,5,6],
        last_name: "a",
        phone: "8",
        slack: "@slackville",
        availability: {
          0 => [true, true, true],
          1 => true,
          2 => [true, true, true],
          3 => [true, true, true],
          4 => [true, true, true],
          5 => [true, true, true],
          6 => [true, true, true]
        }
      }

      put "/api/v1/mentees/#{@user.id}", params: updated

      expect(response.status).to eq(200)
      expect(response).to be_successful
      returned_user = JSON.parse(response.body)["data"]["attributes"]

      expect(returned_user[background]).to eq(updated[:background])
      expect(returned_user[cohort]).to eq(updated[:cohort])
      expect(returned_user[program]).to eq(updated[:program])
      expect(returned_user[email]).to eq(updated[:email])
      expect(returned_user[first_name]).to eq(updated[:first_name])
      expect(returned_user[identities]).to eq(updated[:identities])
      expect(returned_user[last_name]).to eq(updated[:last_name])
      expect(returned_user[phone]).to eq(updated[:phone])
      expect(returned_user[slack]).to eq(updated[:slack])
      expect(returned_user[availability]).to eq(updated[:availability])
    end
  end

  context 'with invalid id' do
    it 'returns 404 status code' do
      put "/api/v1/mentees/12", params: updated

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to eq({"message" => "mentee not found by that id"})
    end
  end
end
