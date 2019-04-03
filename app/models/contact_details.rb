class ContactDetails < ApplicationRecord
  belongs_to :user
  validates_presence_of :preferred_method
end
