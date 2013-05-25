# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invite do
    team
    user
    association :leader, factory: :user
    status 'pending'
  end
end
