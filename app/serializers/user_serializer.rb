class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :cohort, :program, :current_job, :background, :mentor, :location
  attribute :tech_skills do |user|
    user.list_tech_skills
  end
  attribute :availability do |user|
    user.list_availability
  end
  attribute :identities do |user|
    user.list_identities
  end
  attribute :contact_details do |user|
    user.list_contact_details
  end
end
