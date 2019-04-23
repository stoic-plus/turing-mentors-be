class Api::V1::MenteesController < ApplicationController
  def create
    create_user(:mentee, mentee_params)
  end

  def update
    update_user(:mentee, params[:id], mentee_params)
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
