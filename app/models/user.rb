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

  # def update
  #   mentee = User.find_by(id: params[:id])
  #   if mentee
  #     mentee_params.each do |attribute, value|
  #       next unless value
  #       if contact_attribute?(attribute)
  #         update_contact(mentee.id, attribute, value)
  #       elsif attribute == "availability"
  #         update_availability(mentee.id, value)
  #       elsif attribute == "identities"
  #         current_identities = mentee.identities.pluck(:id)
  #         value.each do |identity|
  #           unless current_identities.include?(identity.to_i)
  #             UserIdentity.create(user_id: mentee.id, identity_id: identity.to_i)
  #           end
  #         end
  #       else
  #         value = value.to_i if attribute == "cohort"
  #         mentee.update(attribute.to_sym => value)
  #       end
  #     end
  #     render json: MentorSerializer.new(mentee), status: 200
  #   else
  #     render json: {"message" => "mentee not found by that id"}, status: 404
  #   end
  # end

  def self.update_mentee(mentee, mentee_params)
    mentee_params.each do |attribute, value|
      next unless value
      ContactDetails.update_for_user(mentee, attribute, value) and next if contact_attribute?(attribute)
      if attribute == "availability"
        update_availability(mentee.id, value)
      elsif attribute == "identities"
        current_identities = mentee.identities.pluck(:id)
        value.each do |identity|
          unless current_identities.include?(identity.to_i)
            UserIdentity.create(user_id: mentee.id, identity_id: identity.to_i)
          end
        end
      else
        value = value.to_i if attribute == "cohort"
        mentee.update(attribute.to_sym => value)
      end
    end
  end
  # move to ContactDetails
  def self.update_contact(mentee_id, attribute, value)
    ContactDetails.find_by(user: mentee_id).update(attribute.to_sym => value)
  end

  # move to Availability
  def self.update_availability(mentee_id, value)
    value.each do |day_of_week, availability|
      new_availability = {}
      new_availability[:day_of_week] = day_of_week.to_i
      if availability.class == Array
          new_availability[:morning] = ActiveModel::Type::Boolean.new.cast(availability[0])
          new_availability[:afternoon] = ActiveModel::Type::Boolean.new.cast(availability[1])
          new_availability[:evening] = ActiveModel::Type::Boolean.new.cast(availability[2])
      else
          updated = ActiveModel::Type::Boolean.new.cast(availability)
          new_availability[:morning] = updated
          new_availability[:afternoon] = updated
          new_availability[:evening] = updated
      end
      Availability.find_by(user: mentee_id, day_of_week: day_of_week).update(new_availability)
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
