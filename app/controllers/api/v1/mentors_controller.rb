class Api::V1::MentorsController < ApplicationController
  def index
    mentors = User.get_mentors_by_location_and_tech_skills(params)
    render json: MentorSerializer.new(mentors), status: 200
  end

  def create
    create_user(:mentor, mentor_params)
  end

  def show
    get_user(:mentor, params[:id])
  end

  def update
    update_user(:mentor, params[:id], mentor_params)
  end

  def destroy
    destroy_user(:mentor, params[:id])
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
