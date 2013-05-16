# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_course_progress do
    course_id 1
    user_id 1
    course_progress "MyString"
  end
end
