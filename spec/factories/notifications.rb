# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    source_type "MyString"
    source_id 1
    notification_type "MyString"
    viewed_at "2013-07-04 13:05:07"
  end
end
