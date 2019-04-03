class User < ApplicationRecord
  validates_presence_of :name,
                        :current_job,
                        :active,
                        :background,
                        :location,
                        :mentor
  has_one :contact_details
  has_many :user_identities
  has_many :identities, through: :user_identities
  has_many :user_tech_skills
  has_many :tech_skills, through: :user_tech_skills
  has_many :user_non_tech_skills
  has_many :non_tech_skills, through: :user_non_tech_skills
end
