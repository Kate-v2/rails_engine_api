FactoryBot.define do
  factory :invoice_item do
    item       { nil }
    invoice    { nil }
    sequence(:quantity)   { |n| n }
    sequence(:unit_price) { |n| n * 100 }
  end
end
