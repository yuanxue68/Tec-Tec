FactoryGirl.define do
  factory :message do |u|
    association :conversation, factory: :conversation
    association :user, factory: :user
    u.body Faker::Lorem::sentence
  end
end
