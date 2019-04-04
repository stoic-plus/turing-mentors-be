class User < ApplicationRecord
  scope :mentors, -> { where(mentor: true) }
  scope :denver_mentors, -> { mentors.where(location: "Denver, CO") }
  scope :remote_mentors, -> { mentors.where("location != 'Denver, CO'") }
  scope :and_tech_skills, -> { joins(:tech_skills) }
  scope :tech_skilled_in, ->(languages) { and_tech_skills.where("tech_skills.title": languages) }

  validates_presence_of :name,
                        :current_job,
                        :active,
                        :background,
                        :location
  has_one :contact_details
  has_many :user_identities
  has_many :identities, through: :user_identities
  has_many :user_tech_skills
  has_many :tech_skills, through: :user_tech_skills
  has_many :user_non_tech_skills
  has_many :non_tech_skills, through: :user_non_tech_skills

  def list_tech_skills
    joins(:tech_skills).pluck("tech_skills.title")
  end
end
