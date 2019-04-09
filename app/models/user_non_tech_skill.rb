class UserNonTechSkill < ApplicationRecord
  belongs_to :user
  belongs_to :non_tech_skill

  def self.for_user(non_tech_skill_ids, user)
    non_tech_skill_ids.each do |id|
      create(non_tech_skill_id: id, user: user)
    end
  end
end
