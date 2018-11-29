class TransactionSerializer

  include FastJsonapi::ObjectSerializer

  attributes :id, :credit_card_number, :credit_card_expiration_date, :result

  # belongs_to :invoice

  # TODO test this
  attribute :invoice_id do |object|
    object.invoices.pluck(:id)
  end


end
