require 'active_support/concern'

module UserInfoUpdater
  include ActiveSupport::Concern
  include UserSkillsUpdater
  include UserDemographicsUpdater
  include UserCommunicationUpdater

  def self.update(user_id, user_type, user_params)
    UserCommunicationUpdater.update_contact(user_id, user_params)
    UserCommunicationUpdater.update_availability(user_id, user_params[:availability]) if user_params[:availability]
    UserDemographicsUpdater.update_interests(user_id, user_params[:interests]) if user_params[:interests]
    UserDemographicsUpdater.update_identities(user_id, user_params[:identities]) if user_params[:identities]

    if user_type == :mentor
      UserSkillsUpdater.update_skills(user_id, :tech, user_params[:tech_skills]) if user_params[:tech_skills]
      UserSkillsUpdater.update_skills(user_id, :non_tech, user_params[:non_tech_skills]) if user_params[:non_tech_skills]
    end
  end
end
