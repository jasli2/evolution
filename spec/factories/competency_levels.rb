# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :competency_level do
    level 1
    description "competency_level description"
    competency_id 1
  end
end
