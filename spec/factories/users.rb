FactoryGirl.define do
  factory :user do |u|
    u.email { Faker::Internet::email }
    u.password 'password'
    u.display_name Faker::Name.name
    u.confirmed_at Time.zone.now
    u.created_at Time.zone.now
    u.updated_at Time.zone.now
  end
end
