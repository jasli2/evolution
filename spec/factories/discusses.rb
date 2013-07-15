# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :discuss do
    user_id 1
    course_class_id 1
    title "MyString"
  end
end
