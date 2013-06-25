# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :training_plan_course do |t|
    t.training_plan_id 1
    t.course_id 1
    t.course_type_str "required"
  end
end
