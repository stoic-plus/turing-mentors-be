class UserIdentitys < ApplicationRecord
  belongs_to :user
  belongs_to :identity
end
