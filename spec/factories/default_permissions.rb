# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :default_permission do
    role "MyString"
    model_name "MyString"
    create_permit 1
    edit_permit 1
    read_permit 1
  end
end
