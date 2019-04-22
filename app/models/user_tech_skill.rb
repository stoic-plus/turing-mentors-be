class UserTechSkill < ApplicationRecord
  belongs_to :user
  belongs_to :tech_skill

  def self.for_user(tech_skill_ids, user)
    tech_skill_ids.each do |id|
      create(tech_skill_id: id, user: user)
    end
  end

  def self.update_for_user(user, skill_params)
    current_skills = user.tech_skills.pluck(:id)
    new_skills = skill_params.map(&:to_i).select {|tech_skill| !current_skills.include?(tech_skill)}
    new_skills.each{|tech_skill| self.create(user_id: user.id, tech_skill_id: tech_skill)}
  end
end
