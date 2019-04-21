class ContactDetails < ApplicationRecord
  belongs_to :user
  validates_presence_of :preferred_method

  def self.for_user(contact_info, user)
    create(
      email: contact_info[:email],
      slack: contact_info[:slack],
      phone: contact_info[:phone],
      user: user
    )
  end

  def self.update_for_user(user, detail, updated_value)
    find_by(user: user.id).update(detail.to_sym => updated_value)
  end
end
