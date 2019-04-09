class Api::V1::MentorsController < ApplicationController
  def index
    mentors = User.get_mentors_by_location_and_tech_skills(params)
    render json: UserSerializer.new(mentors), status: 200
  end

  def create
    mentor = User.new_mentor(mentor_params)
    if mentor.save
      User.create_mentor_info(mentor_params, mentor)
      render json: UserSerializer.new(mentor), status: 200
    else
      render json: { message: "incorrect user information supplied"}, status: 400
    end
  end

  private

  def mentor_params
    params.permit(
    :background,
    :cohort,
    :program,
    :location,
    :current_job,
    :email,
    :first_name,
    :last_name,
    :phone,
    :slack,
    :tech_skills => [],
    :non_tech_skills => [],
    :identities => [],
    :availability => {}
  )
  end
end
