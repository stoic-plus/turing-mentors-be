class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :cohort, :program, :current_job, :background, :mentor, :location
  attribute :tech_skills do |user|
    user.list_tech_skills
  end
end
