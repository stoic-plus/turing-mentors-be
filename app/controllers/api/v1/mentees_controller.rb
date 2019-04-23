class Api::V1::MenteesController < ApplicationController
  def create
    create_user(:mentee)
  end

  def update
    mentee = User.find_by(id: params[:id])
    if mentee
      User.update_mentee(mentee, mentee_params)
      render json: MenteeSerializer.new(mentee), status: 200
    else
      render json: {"message" => "mentee not found by that id"}, status: 404
    end
  end

  def destroy
    mentee = User.find_by(id: params[:id])
    if mentee
      User.destroy(mentee.id)
      render nothing: true, status: 204
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
    :availability => {}
  )
  end
end
