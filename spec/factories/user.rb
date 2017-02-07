FactoryGirl.define do
  factory :user do
    email 'sampleuser@example.com'
    password 'sample-password'
    password_confirmation 'sample-password'
  end
end