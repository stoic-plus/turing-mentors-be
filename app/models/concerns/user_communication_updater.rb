require 'active_support/concern'

module UserCommunicationUpdater
  include ActiveSupport::Concern

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

  def self.update_contact(user_id, user_params)
    updated_attributes = {user_id: user_id}
    [:email, :slack, :linkedin, :phone].each do |param|
      updated_attributes[param] = user_params[param] if user_params[param]
    end
    ContactDetails.update(updated_attributes)
  end
end
