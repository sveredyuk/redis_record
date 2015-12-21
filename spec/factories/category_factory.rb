FactoryGirl.define do
  factory :category do
    sequence(:name)     { |n| "category_#{n}" }
    sequence(:position) { |n| n }
  end
end
