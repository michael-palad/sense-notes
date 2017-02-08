FactoryGirl.define do
  factory :note do
    title "Sample Note"
    content "Sample Content for Sample Note"
    user
    category
  end
end