require 'rails_helper'

describe UserInterest, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:interest) }
  end
end
