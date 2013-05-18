# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :competency_user do
    self_eval_level 1
    mgr_eval_level 1
    user_id 1
    competency_id 1
  end
end
