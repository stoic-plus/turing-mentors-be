require 'rails_helper'

describe ContactDetails, type: :model do
  it {should validate_presence_of(:preferred_method)}
end
