require_relative '../../app/models/user'

FactoryBot.define do
  factory :user do
    first_name { Faker  }
  end
end
