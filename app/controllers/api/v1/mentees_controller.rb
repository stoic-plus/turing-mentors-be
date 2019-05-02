class Api::V1::MenteesController < ApplicationController
  def index
    render json: MenteeSerializer.new(User.mentees), status: 200
  end

  def create
    create_user(:mentee, mentee_params)
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
