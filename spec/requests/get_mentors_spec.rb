require 'rails_helper'

describe 'GET /mentors', type: :request do
  before :each do
    @t_1 = TechSkill.create(title: 'javascript')
    @t_2 = TechSkill.create(title: 'ruby')
    User.destroy_all
    @u_1 = User.create(name: 'Travis Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
    UserTechSkill.create(user_id: @u_1.id, tech_skill_id: @t_2.id)

    @u_2 = User.create(name: 'Bob Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'New York, NY')
    UserTechSkill.create(user_id: @u_2.id, tech_skill_id: @t_2.id)

    @u_3 = User.create(name: 'Jordan Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'New York, NY')
    UserTechSkill.create(user_id: @u_3.id, tech_skill_id: @t_1.id)

    @u_4 = User.create(name: 'J J', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
    UserTechSkill.create(user_id: @u_4.id, tech_skill_id: @t_1.id)
  end

    context 'passing location:all as params' do
      it 'returns mentor users in and outside of denver who have any tech skill' do
        get '/api/v1/mentors', params: { location: 'all' }

        expect(response).to be_successful
        expect(response.content_type).to eq("application/json")
        expect(response.status).to eq(200)

        mentor_json = JSON.parse(response.body)["data"]

        expect(mentor_json.size).to eq(4)

        mentor_json.each do |json|
          expect(json).to have_key("id")
          expect(json["type"]).to eq("user")
          expect(json["attributes"]).to have_key("name")
          expect(json["attributes"]).to have_key("cohort")
          expect(json["attributes"]).to have_key("program")
          expect(json["attributes"]).to have_key("cohort")
          expect(json["attributes"]).to have_key("background")
          expect(json["attributes"]).to have_key("location")
          expect(json["attributes"]["mentor"]).to be_truthy
        end
      end
    end
    context 'passing location:denver as params' do
      it 'returns mentor users in denver who have any tech skill' do
        get '/api/v1/mentors', params: { location: 'denver' }

        expect(response).to be_successful
        expect(response.content_type).to eq("application/json")
        expect(response.status).to eq(200)

        mentor_json = JSON.parse(response.body)["data"]

        expect(mentor_json.size).to eq(2)

        mentor_json.each do |json|
          expect(json["attributes"]["location"]).to eq("Denver, CO")
          expect(json["attributes"]["mentor"]).to be_truthy
        end
      end
    end
    context 'passing location:remote as params' do
      it 'returns mentor users outside of denver who have any tech skill' do
        get '/api/v1/mentors', params: { location: 'remote' }

        expect(response).to be_successful
        expect(response.content_type).to eq("application/json")
        expect(response.status).to eq(200)

        mentor_json = JSON.parse(response.body)["data"]

        expect(mentor_json.size).to eq(2)

        mentor_json.each do |json|
          expect(json["attributes"]["location"]).to eq("New York, NY")
          expect(json["attributes"]["mentor"]).to be_truthy
        end
      end
    end
    context 'passing location:all, tech_skills=\'javascript\' as params' do
      it 'returns mentor users in and outside of denver who have javascript as tech skill' do
        get '/api/v1/mentors', params: { location: 'all', tech_skills: 'javascript' }

        expect(response).to be_successful
        expect(response.content_type).to eq("application/json")
        expect(response.status).to eq(200)

        mentor_json = JSON.parse(response.body)["data"]
        expect(mentor_json.size).to eq(2)

        mentor_json.each do |json|
          expect(json["attributes"]["mentor"]).to be_truthy
          expect(json["attributes"]["tech_skills"]).to eq(["javascript"])
        end
      end
    end
    context 'passing location:remote, tech_skills=\'javascript\' as params' do
      it 'returns mentor outside of denver who have javascript as tech skill' do
        get '/api/v1/mentors', params: { location: 'remote', tech_skills: 'javascript' }

        expect(response).to be_successful
        expect(response.content_type).to eq("application/json")
        expect(response.status).to eq(200)

        mentor_json = JSON.parse(response.body)["data"]

        expect(mentor_json.size).to eq(1)
        expect(mentor_json.first["attributes"]["mentor"]).to be_truthy
        expect(mentor_json.first["attributes"]["location"]).to_not eq("Denver, CO")
        expect(mentor_json.first["attributes"]["tech_skills"]).to eq(["javascript"])
      end
    end
    context 'passing location:denver, tech_skills=\'javascript\' as params' do
      it 'returns mentor users in denver who have javascript as tech skill' do
        get '/api/v1/mentors', params: { location: 'denver', tech_skills: 'javascript' }

        expect(response).to be_successful
        expect(response.content_type).to eq("application/json")
        expect(response.status).to eq(200)

        mentor_json = JSON.parse(response.body)["data"]

        expect(mentor_json.size).to eq(1)

        expect(mentor_json.first["attributes"]["mentor"]).to be_truthy
        expect(mentor_json.first["attributes"]["location"]).to eq("Denver, CO")
        expect(mentor_json.first["attributes"]["tech_skills"]).to eq(["javascript"])
      end
    end
    context 'passing location:denver, tech_skills=\'ruby\' as params' do
      it 'returns mentor users in denver who have ruby as tech skill' do
        get '/api/v1/mentors', params: { location: 'denver', tech_skills: 'ruby' }

        expect(response).to be_successful
        expect(response.content_type).to eq("application/json")
        expect(response.status).to eq(200)

        mentor_json = JSON.parse(response.body)["data"]

        expect(mentor_json.size).to eq(1)

        expect(mentor_json.first["attributes"]["mentor"]).to be_truthy
        expect(mentor_json.first["attributes"]["location"]).to eq("Denver, CO")
        expect(mentor_json.first["attributes"]["tech_skills"]).to eq(["ruby"])
      end
    end
    context 'passing location:remote, tech_skills=\'ruby\' as params' do
      it 'returns mentor users not in denver who have ruby as tech skill' do
        get '/api/v1/mentors', params: { location: 'remote', tech_skills: 'ruby' }

        expect(response).to be_successful
        expect(response.content_type).to eq("application/json")
        expect(response.status).to eq(200)

        mentor_json = JSON.parse(response.body)["data"]

        expect(mentor_json.size).to eq(1)

        expect(mentor_json.first["attributes"]["mentor"]).to be_truthy
        expect(mentor_json.first["attributes"]["location"]).to eq("New York, NY")
        expect(mentor_json.first["attributes"]["tech_skills"]).to eq(["ruby"])
      end
    end
    context 'passing location:all, tech_skills=\'ruby\' as params' do
      it 'returns mentor users in and outside of denver who have ruby as tech skill' do
        get '/api/v1/mentors', params: { location: 'all', tech_skills: 'ruby' }

        expect(response).to be_successful
        expect(response.content_type).to eq("application/json")
        expect(response.status).to eq(200)

        mentor_json = JSON.parse(response.body)["data"]

        expect(mentor_json.size).to eq(2)

        mentor_json.each do |json|
          expect(json["attributes"]["mentor"]).to be_truthy
          expect(json["attributes"]["tech_skills"]).to eq(["ruby"])
        end
      end
    end
end

# "data": {
#           "id": "5",
#           "type": "user",
#           "attributes": {
#               "name": "Jordan Gee",
#               "cohort": 1810,
#               "program": "FE",
#               "current_job": "google",
#               "background": "IT",
#               "mentor": true,
#               "location": "New York, NY",
#               "tech_skills": [
#                   "javascript"
#               ],
#               "identities": [
#                   "male"
#               ],
#               "contact_details" : {
#                 "email": "j@mail.com",
#                 "phone": "720",
#                 "slack": "@slack"
#               }
#               "availability": {
#                 "timeFri": [1, 2, 3],
#                 "timeMon": [0],
#                 "timeSat": [0],
#                 "timeSun": [0],
#                 "timeThu": [3, 4],
#                 "timeTue": [2, 3],
#                 "timeWed": [1, 3]
#               }
#           }
#       }
#
#
