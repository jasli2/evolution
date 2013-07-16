# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :action_permission do
    model_permission_id 1
    action_name "MyString"
    user_scope 1
  end
end
