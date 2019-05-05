require 'active_support/concern'

module UserDemographicsUpdater
  include ActiveSupport::Concern

  def self.update_identities(user_id, identities)
    UserIdentity.update_for_user(user_id, identities.map(&:to_i))
  end

  def self.update_interests(user_id, interests)
    UserInterest.update_for_user(user_id, interests.map(&:to_i))
  end
end
