class UserTechSkill < ApplicationRecord
  belongs_to :user
  belongs_to :tech_skill
end
