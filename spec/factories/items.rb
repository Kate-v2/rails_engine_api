FactoryBot.define do
  factory :item do
    sequence(:name)        { |n| "Item #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:unit_price)  { |n| n * 100 }
    sequence(:merchant)    { nil }
  end
end
