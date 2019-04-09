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
end
