# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invite do
    team
    user
    association :leader, factory: :user
    status 'pending'

    trait :accepted do
      status 'accepted'
    end

    factory :accepted_invite, traits: [:accepted]
  end
end
