require 'active_support/concern'

module UserInfoUpdater
  include ActiveSupport::Concern

  def self.update(user_id, user_type, user_params)
    update_contact(user_id, user_params)
    update_interests(user_id, user_params[:interests]) if user_params[:interests]
    update_availability(user_id, user_params[:availability]) if user_params[:availability]
    update_identities(user_id, user_params[:identities]) if user_params[:identities]

    if user_type == :mentor
      update_skills(user_id, :tech, user_params[:tech_skills]) if user_params[:tech_skills]
      update_skills(user_id, :non_tech, user_params[:non_tech_skills]) if user_params[:non_tech_skills]
    end
  end

  private

  def self.update_skills(user_id, type, skills)
    UserTechSkill.update_for_user(user_id, skills.map(&:to_i)) if type == :tech
    UserNonTechSkill.update_for_user(user_id, skills.map(&:to_i)) if type == :non_tech
  end

  def self.update_availability(user_id, availability_params)
     new_availability = availability_params.to_h.reduce({}) do |new_avail, (day_of_week, availability)|
       if availability.class == Array
         new_avail[day_of_week.to_i] = availability.map{|period| period = ActiveModel::Type::Boolean.new.cast(period)}
       else
         updated = ActiveModel::Type::Boolean.new.cast(availability)
         new_avail[day_of_week.to_i] = [updated, updated, updated]
       end
       new_avail
     end
     Availability.update_for_user(user_id, new_availability)
  end

  def self.update_identities(user_id, identities)
    UserIdentity.update_for_user(user_id, identities.map(&:to_i))
  end

  def self.update_interests(user_id, interests)
    UserInterest.update_for_user(user_id, interests.map(&:to_i))
  end

  def self.update_contact(user_id, user_params)
    updated_attributes = {user_id: user_id}
    [:email, :slack, :linkedin, :phone].each do |param|
      updated_attributes[param] = user_params[param] if user_params[param]
    end
    ContactDetails.update(updated_attributes)
  end
end
