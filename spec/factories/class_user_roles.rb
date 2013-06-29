# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :class_user_role do
    course_class_id 1
    user_id 1
    role "MyString"
  end
end
