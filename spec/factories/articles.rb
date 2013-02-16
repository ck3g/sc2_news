# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.words }
    body { Faker::Lorem.paragraphs.join("\n\n") }
    user
    views_count 503

    factory :invalid_article do
      body nil
    end
  end
end
