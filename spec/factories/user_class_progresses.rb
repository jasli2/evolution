# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_class_progress do
    user_id 1
    class_id 1
    training_plan_id 1
    progress "MyString"
  end
end
