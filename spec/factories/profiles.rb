# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    user
    country
    sequence(:profile_url) { |n| "http://eu.battle.net/sc2/en/profile/#{n}/1/name/" }
  end
end
