FactoryGirl.define do
  factory :conversation do |u|
    association :sender, factory: :user
    association :recipient, factory: :user
  end
end
