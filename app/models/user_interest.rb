class UserInterest < ApplicationRecord
  belongs_to :user
  belongs_to :interest

  def self.for_user(interest_ids, mentee)
    interest_ids.each do |id|
      create(interest_id: id, user: mentee)
    end
  end

  def self.update_for_user(user, interest_params)
    current_interests = user.interests.pluck(:id)
    new_interests = interest_params.map(&:to_i).select {|interest| !current_interests.include?(interest)}
    new_interests.each{|interest| UserInterest.create(user_id: user.id, interest_id: interest)}
  end
end
