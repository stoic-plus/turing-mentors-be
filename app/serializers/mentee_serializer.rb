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
    if user.interests
      user.list_interests
    else
      []
    end
  end
  attribute :contact_details do |user|
    if user.contact_details
      user.list_contact_details
    else
      []
    end
  end
end
