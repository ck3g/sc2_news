# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username-#{n}" }
    sequence(:email) { |n| "email-#{n}@example.com" }
    password "secret"

    factory :admin do
      roles :admin

      factory :admin_example_com do
        email "admin@example.com"
        username "admin"
      end
    end

    factory :editor do
      roles :editor
    end

    factory :writer do
      roles :writer
    end

    factory :streamer do
      roles :streamer
    end
  end
end
