
class InvoiceItemSerializer

  include FastJsonapi::ObjectSerializer

  attributes :id, :quantity, :invoice_id, :item_id

  attribute :unit_price do |object|
    object.price
  end

  # attribute :merchant_id do |object|
  #   object.invoice.merchant_id
  # end

end
