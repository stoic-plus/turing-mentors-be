class Availability < ApplicationRecord
  belongs_to :user
  validates :day_of_week, presence: true
  validates :morning, inclusion: { in: [true, false] }
  validates :afternoon, inclusion: { in: [true, false] }
  validates :evening, inclusion: { in: [true, false] }

  def self.update_for_user(user_id, updated_availability)
    updated_availability.each do |day, availability|
      self.where(user_id: user_id, day_of_week: day).update(morning: availability.first, afternoon: availability.second, evening: availability.third)
    end
  end
end
