dependency_container = Dry::Container.new
# may be uneccesary
dependency_container.register('user_availability', -> { Availability })
binding.pry
AutoInject = Dry::AutoInject(dependency_container)
# might be better to create a UserInfo class which itself has dependencies
  # UserInfo has supporting tables as instance variable then gets passed to User

# UserInfo would be similar to a presenter in that it takes all of the supporting tables and joins into one interface

# does this get instantiated with user or class methods where you pass the user?
  # leaning towards first
require 'active_support/concern'

module UserInfo
  extend ActiveSupport::Concern

  def update_mentee(mentee_id, mentee_params)
    update_contact(mentee_id, mentee_params)
    # UserInterest.update_for_user(mentee, value) and next if attribute == "interests"
    # Availability.update_for_user(mentee, value) and next if attribute == "availability"
    # UserIdentity.update_for_user(mentee, value) and next if attribute == "identities"
  end

  def update_mentor(mentor, mentor_params)

  end

  private

  def update_contact(user_id, user_params)
    updated_attributes = {user_id: user_id}
    [:email, :slack, :linkedin, :phone].each do |updated, param|
      updated_attributes[param] = user_params[param] if user_params[param]
    end
    ContactDetails.update(update_attributes)
  end
end
