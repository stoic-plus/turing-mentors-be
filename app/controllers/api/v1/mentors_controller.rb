class Api::V1::MentorsController < ApplicationController
  def index
    mentors = User.get_mentors_by_location(params["location"])
    if params["tech_skills"]
      mentors = mentors.tech_skilled_in(params["tech_skills"])
    end
    render json: UserSerializer.new(mentors), status: 200
  end
end
