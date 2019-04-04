class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :cohort, :program, :current_job, :background, :mentor, :location
  attribute :tech_skills do |user|
    user.list_tech_skills
  end
end
