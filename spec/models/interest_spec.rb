require 'rails_helper'

describe Interest, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
  end
end
