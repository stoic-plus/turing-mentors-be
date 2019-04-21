class Availability < ApplicationRecord
  belongs_to :user
  validates :day_of_week, presence: true
  validates :morning, inclusion: { in: [true, false] }
  validates :afternoon, inclusion: { in: [true, false] }
  validates :evening, inclusion: { in: [true, false] }

  def self.for_user(availability, user)
    availability.each do |day, time_of_day|
      if time_of_day.class == Array
        morning, afternoon, evening = time_of_day
      else
        morning = time_of_day
        afternoon = time_of_day
        evening = time_of_day
      end
      day = day.to_s.to_i if day.class == Symbol
      create(
        day_of_week: day,
        morning: morning,
        afternoon: afternoon,
        evening: evening,
        user_id: user.id
      )
    end
  end

  def self.update_for_user(user, updated_availability)
    updated_availability.each do |day_of_week, availability|
      new_availability = {day_of_week: day_of_week.to_i}
      if availability.class == Array
         [:morning, :afternoon, :evening].each_with_index do |period, index|
           new_availability[period] = ActiveModel::Type::Boolean.new.cast(availability[index])
         end
      else
         updated = ActiveModel::Type::Boolean.new.cast(availability)
         [:morning, :afternoon, :evening].each do |period|
           new_availability[period] = ActiveModel::Type::Boolean.new.cast(updated)
         end
      end
      find_by(user: user.id, day_of_week: day_of_week).update(new_availability)
    end
  end
end
