# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraphs.join("\n\n") }
    views_count 503
    published true

    trait :unpublished do
      published false
    end

    factory :invalid_article do
      body nil
    end

    factory :old_article do
      published_on { 10.days.ago }
    end

    factory :very_old_article do
      published_on { 20.days.ago }
    end

    factory :unpublished_article, traits: [:unpublished]
  end
end
