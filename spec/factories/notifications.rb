FactoryGirl.define do
  factory :notification do |u|
    association :notified_by, factory: :user
    association :user, factory: :user
    association :auction, factory: :auction
    u.notice_type "bid over"
  end
end
