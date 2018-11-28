FactoryBot.define do
  factory :transaction do
    invoice                       { nil }
    sequence(:credit_card_number) {|n| (1234567890123456 + n).to_s }
    # credit_card_expiration_date   { rand(Date.now..(Date.now+10) }
    credit_card_expiration_date   { "" }
    result                        { "success" }
  end
end
