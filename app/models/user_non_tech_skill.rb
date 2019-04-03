class UserNonTechSkill < ApplicationRecord
  belongs_to :user
  belongs_to :non_tech_skill
end
