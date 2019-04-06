class User < ApplicationRecord
  scope :mentors, -> { where(mentor: true) }
  scope :denver_mentors, -> { mentors.where(location: "Denver, CO") }
  scope :remote_mentors, -> { mentors.where("location != 'Denver, CO'") }
  scope :and_tech_skills, -> { joins(:tech_skills) }
  scope :tech_skilled_in, ->(languages) { and_tech_skills.where("tech_skills.title": languages) }

  validates_presence_of :first_name,
                        :last_name,
                        :current_job,
                        :background,
                        :location
  has_one :contact_details
  has_many :availabilities
  has_many :user_identities
  has_many :identities, through: :user_identities
  has_many :user_tech_skills
  has_many :tech_skills, through: :user_tech_skills
  has_many :user_non_tech_skills
  has_many :non_tech_skills, through: :user_non_tech_skills

  def list_tech_skills
    UserTechSkill.joins(:tech_skill).where(user_id: self.id).pluck("tech_skills.title")
  end

  def self.get_mentors_by_location(location_param)
    return User.mentors if location_param == "all"
    return User.denver_mentors if location_param == "denver"
    return User.remote_mentors if location_param == "remote"
  end
end
