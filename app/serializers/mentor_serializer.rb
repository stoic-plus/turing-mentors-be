class MentorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :cohort, :program, :current_job, :background, :mentor, :location
  attribute :tech_skills do |user|
    user.list_skills(:tech)
  end
  attribute :non_tech_skills do |user|
    user.list_skills(:non_tech)
  end
  attribute :interests do |user|
    user.list_interests
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
