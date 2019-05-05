class Api::V1::MenteesController < ApplicationController
  def index
    render json: MenteeSerializer.new(User.mentees), status: 200
  end

  def create
    missing_params = missing_params?(mentee_params)
    return create_user(:mentee, mentee_params) unless missing_params
    render json: {"message" => "insufficient user information supplied - missing : #{missing_params.to_s.gsub("\"", '')}"}, status: 400
  end

  def show
    mentee = User.find_by(id: params[:id], mentor: false)
    if mentee
      serialize_user(:mentee, mentee)
    else
      render json: {"message" => "mentee not found by that id"}, status: 404
    end
  end

  def update
    mentee = User.find_by(id: params[:id], mentor: false)
    if mentee
      update_user(:mentee, mentee, mentee_params)
    else
      render json: {"message" => "mentee not found by that id"}, status: 404
    end
  end

  def destroy
    mentee = User.find_by(id: params[:id], mentor: false)
    if mentee
      destroy_user(:mentor, mentee)
    else
      render json: {"message" => "mentee not found by that id"}, status: 404
    end
  end

  private

  def missing_params?(params)
    required = [:availability, :background, :cohort, :email, :first_name, :identities, :interests, :last_name, :phone, :program, :slack]
    return false if params.keys.length == required.length
    required.select{|r_param| !params.keys.include?(r_param.to_s) }.map(&:to_s)
  end

  def mentee_params
    params.permit(
    :background,
    :cohort,
    :program,
    :email,
    :first_name,
    :last_name,
    :phone,
    :slack,
    :identities => [],
    :interests => [],
    :availability => {}
  )
  end
end
