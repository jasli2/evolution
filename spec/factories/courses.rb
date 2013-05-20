# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    title "English"
    author "jc li"
    filter_item "Language"
  end
end
