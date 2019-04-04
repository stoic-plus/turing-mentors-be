class Api::V1::MentorsController < ApplicationController
  def index
    mentors = get_mentors_by_location(params["location"])
    if params["tech_skills"]
      mentors = mentors.tech_skilled_in('Javascript')
    end
    render json: UserSerializer.new(mentors), status: 200
  end

  def get_mentors_by_location(location_param)
    return User.mentors if location_param == "all"
    return User.denver_mentors if location_param == "denver"
    return User.remote_mentors if location_param == "remote"
  end
end
