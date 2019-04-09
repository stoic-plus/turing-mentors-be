class Api::V1::MentorsController < ApplicationController
  def index
    mentors = User.get_mentors_by_location(params["location"])
    if params["tech_skills"]
      mentors = mentors.tech_skilled_in(params["tech_skills"].split(","))
    end
    render json: UserSerializer.new(mentors), status: 200
  end

  def create
    mentor = User.new_mentor(mentor_params)
    if mentor.save
      ContactDetails.for_user(mentor_params, mentor)
      UserIdentity.for_user(mentor_params[:identities].map(&:to_i), mentor)
      UserTechSkill.for_user(mentor_params[:tech_skills].map(&:to_i), mentor)
      UserNonTechSkill.for_user(mentor_params[:non_tech_skills].map(&:to_i), mentor)
      Availability.for_user(mentor_params[:availability], mentor)
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
