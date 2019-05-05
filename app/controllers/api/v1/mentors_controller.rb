class Api::V1::MentorsController < ApplicationController
  def index
    mentors = User.get_mentors_by_location_and_tech_skills(params)
    render json: MentorSerializer.new(mentors), status: 200
  end

  def create
    missing_params = missing_params?(mentor_params)
    return create_user(:mentor, mentor_params) unless missing_params
    render json: {"message" => "insufficient user information supplied - missing : #{missing_params.to_s.gsub("\"", '')}"}, status: 400
  end

  def show
    mentor = User.find_by(id: params[:id], mentor: true)
    if mentor
      serialize_user(:mentor, mentor)
    else
      render json: {"message" => "mentor not found by that id"}, status: 404
    end
  end

  def update
    mentor = User.find_by(id: params[:id], mentor: true)
    if mentor
      update_user(:mentor, mentor, mentor_params)
    else
      render json: {"message" => "mentor not found by that id"}, status: 404
    end
  end

  def destroy
    mentor = User.find_by(id: params[:id], mentor: true)
    if mentor
      destroy_user(:mentor, mentor)
    else
      render json: {"message" => "mentor not found by that id"}, status: 404
    end
  end

  private

  def missing_params?(params)
    required = [:availability, :background, :cohort, :current_job, :email, :first_name, :identities, :interests, :last_name, :location, :non_tech_skills, :phone, :program, :slack, :tech_skills]
    return false if params.keys.length == required.length
    required.select{|r_param| !params.keys.include?(r_param.to_s) }.map(&:to_s)
  end

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
    :interests => [],
    :availability => {}
    )
  end
end
