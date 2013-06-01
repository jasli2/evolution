# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    qdata "MyText"
    answer "MyString"
  end
end
