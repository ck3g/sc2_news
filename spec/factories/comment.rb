
FactoryGirl.define do
  factory :comment do
    title { Faker::Lorem.sentence }
    comment { Faker::Lorem.paragraph }
    ip_address "8.8.8.8"
    user
    commentable factory: :article

    factory :invalid_comment do
      comment nil
    end
  end
end
