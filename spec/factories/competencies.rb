# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :competency do
    name "competency name"
    description "competency description"
    category_id 1
  end
end
