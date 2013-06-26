# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :todo do
    source_type "MyString"
    source_id 1
    finish_at "2013-06-26 15:05:28"
    deadline "2013-06-26 15:05:28"
    type ""
  end
end
