class UserIdentity < ApplicationRecord
  belongs_to :user
  belongs_to :identity

  def self.for_user(identity_ids, user)
    identity_ids.each do |id|
      create(identity_id: id, user: user)
    end
  end

  def self.update_for_user(user, identity_params)
    current_identities = user.identities.pluck(:id)
    new_identities = identity_params.map(&:to_i).select {|identity| !current_identities.include?(identity)}
    new_identities.each{|identity| UserIdentity.create(user_id: user.id, identity_id: identity)}
  end
end
