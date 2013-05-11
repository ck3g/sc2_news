# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :our_friend do
    title "MyString"
    url "MyString"
    image "MyString"
    visible true

    factory :hidden_our_friend do
      visible false
    end
  end
end
