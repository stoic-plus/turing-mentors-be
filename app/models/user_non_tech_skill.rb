class UserNonTechSkill < ApplicationRecord
  belongs_to :user
  belongs_to :non_tech_skill

  def self.for_user(non_tech_skill_ids, user)
    non_tech_skill_ids.each do |id|
      create(non_tech_skill_id: id, user: user)
    end
  end

  def self.update_for_user(user, skill_params)
    current_skills = user.non_tech_skills.pluck(:id)
    new_skills = skill_params.map(&:to_i).select {|non_tech_skill| !current_skills.include?(non_tech_skill)}
    new_skills.each{|non_tech_skill| self.create(user_id: user.id, non_tech_skill_id: non_tech_skill)}
  end
end
