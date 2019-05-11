require 'active_support/concern'

module UserInfoUpdater
  include UserContactUpdater
  include ActiveSupport::Concern

  def self.update(user_id, user_type, user_params)
    UserContactUpdater.update(user_id, user_params)
    update_interests(user_id, user_params[:interests]) if user_params[:interests]
    update_identities(user_id, user_params[:identities]) if user_params[:identities]

    if user_type == :mentor
      update_skills(user_id, :tech, user_params[:tech_skills]) if user_params[:tech_skills]
      update_skills(user_id, :non_tech, user_params[:non_tech_skills]) if user_params[:non_tech_skills]
    end
  end

  private

  def self.update_skills(user_id, type, skills)
    UserTechSkill.update_for_user(user_id, skills.map(&:to_i)) if type == :tech
    UserNonTechSkill.update_for_user(user_id, skills.map(&:to_i)) if type == :non_tech
  end

  def self.update_identities(user_id, identities)
    UserIdentity.update_for_user(user_id, identities.map(&:to_i))
  end

  def self.update_interests(user_id, interests)
    UserInterest.update_for_user(user_id, interests.map(&:to_i))
  end
end
