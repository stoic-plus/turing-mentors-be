require 'rails_helper'

describe Availability, type: :model do
  it {should validate_presence_of(:day_of_week)}
  it {should validate_presence_of(:start)}
  it {should validate_presence_of(:end)}
  it {should belong_to(:user)}
end
