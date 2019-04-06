require 'rails_helper'

describe Availability, type: :model do
  it {should validate_presence_of(:day_of_week)}
  it {should validate_inclusion_of(:morning).in_array([true, false])}
  it {should validate_inclusion_of(:afternoon).in_array([true, false])}
  it {should validate_inclusion_of(:evening).in_array([true, false])}
  it {should belong_to(:user)}
end
