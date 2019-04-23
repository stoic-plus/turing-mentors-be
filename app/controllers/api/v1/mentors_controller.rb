class Api::V1::MentorsController < ApplicationController
  def index
    mentors = User.get_mentors_by_location_and_tech_skills(params)
    render json: MentorSerializer.new(mentors), status: 200
  end

  def create
    create_user(:mentor)
  end

  def update
    mentor = User.find_by(id: params[:id])
    if mentor
      User.update_mentor(mentor, mentor_params)
      render json: MentorSerializer.new(mentor), status: 200
    else
      render json: {"message" => "mentor not found by that id"}, status: 404
    end
  end

  def destroy
    mentor = User.find_by(id: params[:id])
    if mentor
      User.destroy(mentor.id)
      render nothing: true, status: 204
    else
      render json: {"message" => "mentee not found by that id"}, status: 404
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
