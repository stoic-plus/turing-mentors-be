require 'rails_helper'

describe 'GET /mentors', type: :request do
  before :each do
    @t_1 = TechSkill.create(title: 'javascript')
    @t_2 = TechSkill.create(title: 'ruby')
    @t_3 = TechSkill.create(title: 'python')
    
    @u_1 = User.create(first_name: 'Travis', last_name: ' Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
    UserTechSkill.create(user_id: @u_1.id, tech_skill_id: @t_2.id)
    ContactDetails.create(email: 't@mail.com', slack: 's1', phone: 'p1', user: @u_1)

    @u_2 = User.create(first_name: 'Bob', last_name: ' Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'New York, NY')
    UserTechSkill.create(user_id: @u_2.id, tech_skill_id: @t_2.id)
    ContactDetails.create(email: 't@mail.com', slack: 's1', phone: 'p1', user: @u_2)

    @u_3 = User.create(first_name: 'Jordan', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'New York, NY')
    UserTechSkill.create(user_id: @u_3.id, tech_skill_id: @t_1.id)
    ContactDetails.create(email: 't@mail.com', slack: 's1', phone: 'p1', user: @u_3)

    @u_4 = User.create(first_name: 'J', last_name: 'J', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
    UserTechSkill.create(user_id: @u_4.id, tech_skill_id: @t_1.id)
    ContactDetails.create(email: 't@mail.com', slack: 's1', phone: 'p1', user: @u_4)

    @u_5 = User.create(first_name: 'JJ', last_name: 'JJJ', cohort: 1811, program: 'BE', current_job: 'google', background: 'IT', mentor: true, location: 'Raleigh, NC')
    UserTechSkill.create(user_id: @u_5.id, tech_skill_id: @t_3.id)
    ContactDetails.create(email: 't@mail.com', slack: 's1', phone: 'p1', user: @u_5)
  end

    context 'passing location:all as params' do
      it 'returns mentor users in and outside of denver who have any tech skill' do
        get '/api/v1/mentors', params: { location: 'all' }

        expect(response).to be_successful
        expect(response.content_type).to eq("application/json")
        expect(response.status).to eq(200)

        mentor_json = JSON.parse(response.body)["data"]

        expect(mentor_json.size).to eq(5)

        mentor_json.each do |json|
          expect(json).to have_key("id")
          expect(json["type"]).to eq("mentor")
          expect(json["attributes"]).to have_key("first_name")
          expect(json["attributes"]).to have_key("last_name")
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

        expect(mentor_json.size).to eq(3)

        mentor_json.each do |json|
          expect(json["attributes"]["location"]).to_not eq("Denver, CO")
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
    context "passing location='all', tech_skills='ruby,python' as params" do
      it 'returns mentors users in and out of denver who have ruby or python as tech skill' do
        get '/api/v1/mentors', params: { location: 'all', tech_skills: 'ruby,python' }

        expect(response).to be_successful
        expect(response.content_type).to eq("application/json")
        expect(response.status).to eq(200)

        mentor_json = JSON.parse(response.body)["data"]

        expect(mentor_json.size).to eq(3)
        mentor_json.each do |json|
          expect(json["attributes"]["mentor"]).to be_truthy
          expect(json["attributes"]["tech_skills"]).to_not include("javascript")
        end
      end
    end
end
