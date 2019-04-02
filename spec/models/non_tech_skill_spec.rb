require 'rails_helper'

describe NonTechSkill, type: :model do
  describe 'validation' do
    it {should validate_presence_of(:title)}
  end
end
