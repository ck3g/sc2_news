# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraphs.join("\n\n") }
    views_count 503

    factory :invalid_article do
      body nil
    end

    factory :old_article do
      created_at { 10.minutes.ago }
    end

    factory :very_old_article do
      created_at { 10.days.ago }
    end
  end
end
