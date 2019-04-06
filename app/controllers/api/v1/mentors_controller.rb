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
    mentor = User.new(user_params)

    if mentor.save
      contact_info = {
        email: mentor_attributes[:email],
        slack: mentor_attributes[:slack],
        phone: mentor_attributes[:phone]
      }
      ContactDetails.create(contact_info)
      identities = Identity.where(id: mentor_attributes[:identities])
      identities.each do |identity|
        binding.pry
        UserIdentity.create(user: mentor, identity: self)
      end
      mentor_attributes[:availability].each do |day, time_of_day|
        morning, afternoon, evening = time_of_day
        Availability.create(
          day_of_week: day,
          morning: morning,
          afternoon: afternoon,
          evening: evening
        )
      end
      render json: UserSerializer.new(mentor), status: 200
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
    :lastName,
    :phone,
    :slack,
    :tech_skills => [],
    :identities => [],
    :availability => {
      "0": [],
      "1": [],
      "2": [],
      "3": [],
      "4": [],
      "5": [],
      "6": [],
    }
  )
  end
end
