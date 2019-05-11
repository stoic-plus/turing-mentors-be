require 'active_support/concern'

module UserInfoCreater
  include ActiveSupport::Concern

  def self.create(user, user_type, user_params)
    create_contact_info(user, user_params)
    create_identities(user, user_params)
    create_interests(user, user_params)
    create_availabilities(user, user_params)

    if user_type == :mentor
      create_tech_skills(user, user_params)
      create_non_tech_skills(user, user_params)
    end
  end

  private

  def self.create_contact_info(user, user_params)
    ContactDetails.create({
      email: user_params[:email],
      slack: user_params[:slack],
      phone: user_params[:phone],
      user: user
    })
  end

  def self.create_identities(user, user_params)
    attribute_ids(user_params, :identities).each do |identity_id|
      UserIdentity.create(identity_id: identity_id, user: user)
    end
  end

  def self.create_interests(user, user_params)
    attribute_ids(user_params, :interests).each do |interest_id|
      UserInterest.create(interest_id: interest_id, user: user)
    end
  end

  def self.create_tech_skills(user, user_params)
    attribute_ids(user_params, :tech_skills).each do |tech_skill|
      UserTechSkill.create(tech_skill_id: tech_skill, user: user)
    end
  end

  def self.create_non_tech_skills(user, user_params)
    attribute_ids(user_params, :non_tech_skills).each do |non_tech_skill|
      UserNonTechSkill.create(non_tech_skill_id: non_tech_skill, user: user)
    end
  end

  def self.create_availabilities(user, user_params)
    user_params[:availability].each do |day, time_of_day|
      morning, afternoon, evening = time_of_day
      day = day.to_s.to_i if day.class == Symbol
      Availability.create(
        day_of_week: day,
        morning: morning,
        afternoon: afternoon,
        evening: evening,
        user_id: user.id
      )
    end
  end

  def self.attribute_ids(params, attribute)
    params[attribute].map(&:to_i)
  end
end
