class ContactDetail < ApplicationRecord
  validates_presence_of :preferred_method
end
