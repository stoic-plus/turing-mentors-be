class User < ApplicationRecord
  validates_presence_of :name,
                        :current_job,
                        :active,
                        :background,
                        :location,
                        :mentor
  has_many :contact_details
  has_many :tech_skills, through: :user_tech_skills
  has_many :nontech_skills, through: :user_nontech_skills
end
