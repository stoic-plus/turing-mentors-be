class UserTechSkill < ApplicationRecord
  belongs_to :user
  belongs_to :tech_skill

  def self.for_user(tech_skill_ids, user)
    tech_skill_ids.each do |id|
      create(tech_skill_id: id, user: user)
    end
  end
end
