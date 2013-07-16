# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :model_permission do
    user_id 1
    model_name "MyString"
  end
end
