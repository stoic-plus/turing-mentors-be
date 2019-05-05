# might be better to create a UserInfo class which itself has dependencies
  # UserInfo has supporting tables as instance variable then gets passed to User

require 'active_support'

module UserInfo
  include ActiveSupport::Concern

  def self.update(mentee_id, mentee_params)
    update_contact(mentee_id, mentee_params)
    update_interests(mentee_id, mentee_params[:interests]) if mentee_params[:interests]
    update_availability(mentee_id, mentee_params[:availability]) if mentee_params[:availability]
    update_identities(mentee_id, mentee_params[:identities]) if mentee_params[:identities]
  end

  def self.update_mentor(mentor, mentor_params)

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

  private

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
