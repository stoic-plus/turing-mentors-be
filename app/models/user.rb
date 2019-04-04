class User < ApplicationRecord
  scope :mentors, -> { where(mentor: true) }
  scope :denver_mentors, -> { mentors.where(location: "Denver, CO") }
  scope :remote_mentors, -> { mentors.where("location != 'Denver, CO'") }
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

  def self.tech_skilled_in(languages)
     # SELECT name, title FROM users INNER JOIN user_tech_skills ON user_tech_skills.user_id=users.id INNER JOIN tech_skills ON user_tech_skills.tech_skill_id=tech_skills.id;
#      name    |   title
# ------------+------------
# Travis Gee | Ruby
# Bob Gee    | Ruby
# Jordan Gee | Javascript
# J J        | Javascript
# J J        | Ruby
  end
end
