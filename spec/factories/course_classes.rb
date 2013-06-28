# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course_class do
    course_id 1
    state "MyString"
  end
end
