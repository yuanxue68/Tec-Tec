FactoryGirl.define do
  factory :user do |u|
    u.email 'tets@gmail.com'
    u.password 'password'
    u.confirmed_at Time.zone.now
    u.created_at Time.zone.now
    u.updated_at Time.zone.now
  end
end
