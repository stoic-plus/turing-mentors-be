class Api::V1::MentorsController < ApplicationController
  def index
    mentors = User.get_mentors_by_location(params["location"])
    if params["tech_skills"]
      mentors = mentors.tech_skilled_in(params["tech_skills"])
    end
    render json: UserSerializer.new(mentors), status: 200
  end

  def create
    mentor_attributes = mentor_params
    user_params = {
      first_name: mentor_attributes[:firstName],
      last_name: mentor_attributes[:lastName],
      cohort: mentor_attributes[:cohort],
      program: mentor_attributes[:program],
      background: mentor_attributes[:background]
    }
    user = User.new(user_params)

    if user.save
      contact_info = {
        email: mentor_attributes[:email],
        slack: mentor_attributes[:slack],
        phone: mentor_attributes[:phone]
      }
      ContactDetails.create(contact_info)
      mentor_attributes[:identities].each do |identity_id|
        UserIdentity.create(user: user, identity: identity_id)
      end

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
    :email,
    :firstName,
    :tech_skills,
    :identities,
    :lastName,
    :phone,
    :slack,
    :timeFri,
    :timeMon,
    :timeSat,
    :timeSun,
    :timeThu,
    :timeTue,
    :timeWed
  )
  end
end
