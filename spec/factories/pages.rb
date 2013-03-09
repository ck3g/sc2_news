# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    sequence(:permalink) { |n| "permalink-#{n}" }
    sequence(:title) { |n| "Page Title ##{n}" }
    content "MyText"
    description "MyString"
    keywords "MyString"
    enabled true

    trait :disabled do
      enabled false
    end

    factory :disabled_page, traits: [:disabled]

    factory :invalid_page do
      permalink nil
      title :nil
    end

    factory :about_page do
      permalink "about"
      title "About Us"
    end

    factory :jobs_page do
      permalink "jobs"
      title "Jobs"
    end
  end
end
