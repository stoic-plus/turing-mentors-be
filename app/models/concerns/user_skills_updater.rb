require 'active_support/concern'

module UserSkillsUpdater
  include ActiveSupport::Concern

  def self.update_skills(user_id, type, skills)
    UserTechSkill.update_for_user(user_id, skills.map(&:to_i)) if type == :tech
    UserNonTechSkill.update_for_user(user_id, skills.map(&:to_i)) if type == :non_tech
  end
end
