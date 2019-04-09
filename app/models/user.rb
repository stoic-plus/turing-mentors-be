class User < ApplicationRecord
  scope :mentors, -> { where(mentor: true) }
  scope :denver_mentors, -> { mentors.where(location: "Denver, CO") }
  scope :remote_mentors, -> { mentors.where("location != 'Denver, CO'") }
  scope :and_tech_skills, -> { joins(:tech_skills) }
  scope :tech_skilled_in, ->(languages) { and_tech_skills.where("tech_skills.title": languages).uniq }

  validates_presence_of :first_name,
                        :last_name,
                        :current_job,
                        :background,
                        :location
  has_one :contact_details
  has_many :availabilities
  has_many :user_identities
  has_many :identities, through: :user_identities
  has_many :user_tech_skills
  has_many :tech_skills, through: :user_tech_skills
  has_many :user_non_tech_skills
  has_many :non_tech_skills, through: :user_non_tech_skills

  def list_skills(type)
    if type === :tech
      list_tech_skills
    else
      list_non_tech_skills
    end
  end

  def list_availability
    Availability.where(user: self).pluck(:day_of_week, :morning, :afternoon, :evening)
      .reduce({}) do |availability, day_of_week|
        availability[day_of_week[0]] = day_of_week.slice(1, 4)
        availability
      end
  end

  def list_identities
    UserIdentity.joins(:identity).where("user_identities.user_id = ?", self.id).pluck(:title)
  end

  def list_contact_details
    contact_details = self.contact_details
    return {
      email: contact_details.email,
      slack: contact_details.slack,
      phone: contact_details.phone
    }
  end

  def self.get_mentors_by_location(location_param)
    return User.mentors if location_param == "all"
    return User.denver_mentors if location_param == "denver"
    return User.remote_mentors if location_param == "remote"
  end

  def self.new_mentor(attributes)
    mentor_attributes = {
      first_name: attributes[:first_name],
      last_name: attributes[:last_name],
      location: attributes[:location],
      current_job: attributes[:current_job],
      cohort: attributes[:cohort],
      program: attributes[:program],
      background: attributes[:background],
      mentor: true
    }
    new(mentor_attributes)
  end

  private

  def list_tech_skills
    UserTechSkill.joins(:tech_skill).where(user_id: self.id).pluck("tech_skills.title")
  end

  def list_non_tech_skills
    UserNonTechSkill.joins(:non_tech_skill).where(user_id: self.id).pluck("non_tech_skills.title")
  end
end
