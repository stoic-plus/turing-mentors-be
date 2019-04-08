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
      first_name: mentor_attributes[:first_name],
      last_name: mentor_attributes[:last_name],
      current_job: mentor_attributes[:current_job],
      cohort: mentor_attributes[:cohort],
      program: mentor_attributes[:program],
      background: mentor_attributes[:background],
      mentor: true
    }
    mentor = User.new(user_params)
    if mentor.save
      contact_info = {
        email: mentor_attributes[:email],
        slack: mentor_attributes[:slack],
        phone: mentor_attributes[:phone],
        user: mentor
      }
      ContactDetails.create(contact_info)
      identities = Identity.where(id: mentor_attributes[:identities].map(&:to_i))
      identities.each do |identity|
        mentor.identities << identity
      end
      tech_skills = TechSkill.where(id: mentor_attributes[:tech_skills].map(&:to_i))
      tech_skills.each do |tech_skill|
        mentor.tech_skills << tech_skill
      end
      non_tech_skills = NonTechSkill.where(id: mentor_attributes[:non_tech_skills].map(&:to_i))
      non_tech_skills.each do |non_tech_skill|
        mentor.non_tech_skills << non_tech_skill
      end
      mentor_attributes[:availability].each do |day, time_of_day|
        if time_of_day.class == Array
          morning, afternoon, evening = time_of_day
        else
          morning = time_of_day
          afternoon = time_of_day
          evening = time_of_day
        end
        mentor.availabilities << Availability.create(
          day_of_week: day,
          morning: morning,
          afternoon: afternoon,
          evening: evening,
          user: mentor
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
