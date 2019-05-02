class UserInterest < ApplicationRecord
  belongs_to :user
  belongs_to :interest

  def self.for_user(interest_ids, mentee)
    interest_ids.each do |id|
      create(interest_id: id, user: mentee)
    end
  end
end
