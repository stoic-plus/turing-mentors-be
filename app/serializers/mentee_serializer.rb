class MenteeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :cohort, :program, :background, :mentor
  attribute :availability do |user|
    user.list_availability
  end
  attribute :identities do |user|
    user.list_identities
  end
  attribute :interests do |user|
    user.list_interests
  end
  attribute :contact_details do |user|
    user.list_contact_details
  end
end
