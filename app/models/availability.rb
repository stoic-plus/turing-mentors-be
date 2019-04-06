class Availability < ApplicationRecord
  belongs_to :user
  validates :day_of_week, presence: true
  validates :morning, inclusion: { in: [true, false] }
  validates :afternoon, inclusion: { in: [true, false] }
  validates :evening, inclusion: { in: [true, false] }
end
