class User < ApplicationRecord
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

  def self.update_mentee(mentee, mentee_params)
    mentee_params.each do |attribute, value|
      next unless value
      ContactDetails.update_for_user(mentee, attribute, value) and next if contact_attribute?(attribute)
      Availability.update_for_user(mentee, value) and next if attribute == "availability"
      UserIdentity.update_for_user(mentee, value) and next if attribute == "identities"

      value = value.to_i if attribute == "cohort"
      mentee.update(attribute.to_sym => value)
    end
  end

  def self.update_mentor(mentor, mentor_params)
    mentor_params.each do |attribute, value|
      next unless value
      ContactDetails.update_for_user(mentor, attribute, value) and next if contact_attribute?(attribute)
      Availability.update_for_user(mentor, value) and next if attribute == "availability"
      UserIdentity.update_for_user(mentor, value) and next if attribute == "identities"
      UserTechSkill.update_for_user(mentor, value) and next if attribute == "tech_skills"
      UserNonTechSkill.update_for_user(mentor, value) and next if attribute == "non_tech_skills"

      value = value.to_i if attribute == "cohort"
      mentor.update(attribute.to_sym => value)
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
    ContactDetails.for_user(mentee_params, mentee)
    UserIdentity.for_user(mentee_params[:identities].map(&:to_i), mentee)
    Availability.for_user(mentee_params[:availability], mentee)
  end

  def self.create_mentor_info(mentor_params, mentor)
    ContactDetails.for_user(mentor_params, mentor)
    UserIdentity.for_user(mentor_params[:identities].map(&:to_i), mentor)
    UserTechSkill.for_user(mentor_params[:tech_skills].map(&:to_i), mentor)
    UserNonTechSkill.for_user(mentor_params[:non_tech_skills].map(&:to_i), mentor)
    Availability.for_user(mentor_params[:availability], mentor)
  end

  private

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
