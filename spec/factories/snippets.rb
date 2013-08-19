# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :snippet do
    text "some sample text"
    secret false
  end
end
