FactoryGirl.define do
  factory :auction do |f|
    f.name "good auction"
    f.description "this is a good auction"
    f.course_code "ece151"
    f.school "uoft"
    f.starting_price 2.00
    f.buyout_price 5.00
    f.start_time Time.zone.now
    f.end_time Time.zone.now + 2.days
    association :owner, factory: :user
  end
end
