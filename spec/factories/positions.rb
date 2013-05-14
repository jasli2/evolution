# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :position do
    name { Faker::Name.name }
    description "position description"
  end
end
