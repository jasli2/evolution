# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :user do
    name { "hutuxiansheng"}
    email { Faker::Internet.email }
    password "hutu1034"
    password_confirmation "hutu1034"
    position
  end
end
