FactoryGirl.define do
  factory :bid do |f|
    association :user, factory: :user, strategy: :build
    association :auction, factory: :auction, strategy: :build
    f.bid_amount 5.00
  end
end
