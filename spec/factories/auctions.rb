FactoryGirl.define do
  factory :auction do |f|
    f.name Faker::Book.title
    f.description Faker::Lorem.sentence
    f.course_code "ece151"
    f.school Faker::University.name
    f.starting_price 2.00
    f.buyout_price 5.00
    f.start_time Time.now
    f.end_time Time.now + 1.days
    association :owner, factory: :user
  end
end
