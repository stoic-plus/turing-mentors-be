class Api::V1::MenteesController < ApplicationController
  def create
    create_user(:mentee, mentee_params)
  end

  def update
    update_user(:mentee, params[:id], mentee_params)
  end

  def destroy
    destroy_user(:mentee, params[:id])
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
