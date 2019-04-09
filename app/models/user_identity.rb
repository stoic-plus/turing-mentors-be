class UserIdentity < ApplicationRecord
  belongs_to :user
  belongs_to :identity

  def self.for_user(identity_ids, user)
    identity_ids.each do |id|
      create(identity_id: id, user: user)
    end
  end
end
