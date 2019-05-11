require 'active_support/concern'

module UserContactUpdater
  include ActiveSupport::Concern

  def self.update(user_id, user_params)
    update_contact(user_id, user_params)
    update_availability(user_id, user_params[:availability]) if user_params[:availability]
  end

  def self.update_contact(user_id, user_params)
    updated_attributes = {user_id: user_id}
    [:email, :slack, :linkedin, :phone].each do |param|
      updated_attributes[param] = user_params[param] if user_params[param]
    end
    ContactDetails.update(updated_attributes)
  end

  def self.update_availability(user_id, availability_params)
     new_availability = availability_params.to_h.reduce({}) do |new_avail, (day_of_week, availability)|
       new_avail[day_of_week.to_i] = availability.map{|period| ActiveModel::Type::Boolean.new.cast(period)}
       new_avail
     end
     Availability.update_for_user(user_id, new_availability)
  end
end
