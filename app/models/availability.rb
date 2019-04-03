class Availability < ApplicationRecord
  belongs_to :user
  validates_presence_of :day_of_week, :start, :end
end
