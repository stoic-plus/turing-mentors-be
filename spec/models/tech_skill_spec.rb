require 'rails_helper'

describe TechSkill, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
  end
end
