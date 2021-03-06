# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    association :leader, factory: :user
    sequence(:name) { |n| "Team-#{ n }" }
    description "Team description"
  end
end
