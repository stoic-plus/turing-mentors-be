class Api::V1::MentorsController < ApplicationController
  def index
    mentors = User.tech_skilled_in(params["tech_skills"]) if params["tech_skills"]
    render json: UserSerializer.new(mentors), status: 200
  end
end
