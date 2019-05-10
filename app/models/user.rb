class User < ApplicationRecord
  include UserInfoUpdater
  include UserInfoCreater
  scope :mentors, -> { where(mentor: true) }
  scope :mentees, -> { where(mentor: false) }
  scope :denver_mentors, -> { mentors.where(location: "Denver, CO") }
  scope :remote_mentors, -> { mentors.where("location != 'Denver, CO'") }
  scope :and_tech_skills, -> { joins(:tech_skills) }
  scope :tech_skilled_in, ->(languages) { and_tech_skills.where("tech_skills.title": languages).uniq }
  validates_presence_of :first_name,
                        :last_name,
                        :current_job,
                        :background,
                        :location
  has_one :contact_details, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :user_identities, dependent: :destroy
  has_many :identities, through: :user_identities
  has_many :user_tech_skills, dependent: :destroy
  has_many :tech_skills, through: :user_tech_skills
  has_many :user_non_tech_skills, dependent: :destroy
  has_many :non_tech_skills, through: :user_non_tech_skills
  has_many :user_interests
  has_many :interests, through: :user_interests

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

  def list_interests
    UserInterest.joins(:interest).where("user_interests.user_id = ?", self.id).pluck(:title)
  end

  def self.update_user(user, user_type, user_params)
    UserInfoUpdater.update(user.id, user_type, user_params)
    user_attributes(user_type).each do |attribute|
      update_user_attribute(user, user_params[attribute], attribute) if user_params[attribute]
    end
  end

  def list_contact_details
    contact_details = self.contact_details
    return {
      email: contact_details.email,
      slack: contact_details.slack,
      phone: contact_details.phone
    }
  end

  def self.get_mentors_by_location_and_tech_skills(params)
    mentors = self.get_mentors_by_location(params["location"])
    mentors = mentors.tech_skilled_in(params["tech_skills"].split(",")) if params["tech_skills"]
    mentors
  end

  def self.get_mentors_by_location(location_param)
    return User.mentors if location_param == "all"
    return User.denver_mentors if location_param == "denver"
    return User.remote_mentors if location_param == "remote"
  end

  def self.new_mentee(attributes)

    mentee_attributes = {
      first_name: attributes[:first_name],
      last_name: attributes[:last_name],
      cohort: attributes[:cohort],
      program: attributes[:program],
      background: attributes[:background],
      mentor: false
    }
    new(mentee_attributes)
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

  def self.create_mentee_info(mentee_params, mentee)
    UserInfoCreater.create(mentee, :mentee, mentee_params)
  end

  def self.create_mentor_info(mentor_params, mentor)
    UserInfoCreater.create(mentor, :mentor, mentor_params)
  end

  private

  def self.user_attributes(type)
    attributes = [:background, :cohort, :program, :first_name, :last_name]
    attributes.concat([:current_job, :location]) if type == :mentor
    attributes
  end

  def self.update_user_attribute(user, new_attribute, attribute)
    user.update(attribute => new_attribute.to_i) if attribute == :cohort
    user.update(attribute => new_attribute)
  end

  def self.contact_attribute?(attribute)
    return true if attribute == "phone"
    return true if attribute == "slack"
    return true if attribute == "email"
    false
  end

  def list_tech_skills
    UserTechSkill.joins(:tech_skill).where(user_id: self.id).pluck("tech_skills.title")
  end

  def list_non_tech_skills
    UserNonTechSkill.joins(:non_tech_skill).where(user_id: self.id).pluck("non_tech_skills.title")
  end
end
