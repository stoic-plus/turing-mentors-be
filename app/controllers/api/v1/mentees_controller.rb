class Api::V1::MenteesController < ApplicationController
  def create
    mentee = User.new_mentee(mentee_params)
    if mentee.save
      User.create_mentee_info(mentee_params, mentee)
      render json: MenteeSerializer.new(mentee), status: 200
    else
      render json: { message: "incorrect user information supplied"}, status: 400
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
