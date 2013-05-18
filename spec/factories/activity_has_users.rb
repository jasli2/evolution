# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity_has_user do
    activity_id 1
    user_id 1
  end
end
