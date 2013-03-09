# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    sequence(:permalink) { |n| "permalink-#{n}" }
    title "MyString"
    content "MyText"
    description "MyString"
    keywords "MyString"
    enabled true

    trait :disabled do
      enable false
    end

    factory :disabled_page, traits: [:disabled]
  end
end
