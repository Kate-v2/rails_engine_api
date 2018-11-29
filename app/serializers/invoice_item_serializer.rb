
class InvoiceItemSerializer

  include FastJsonapi::ObjectSerializer

  attributes :id, :quantity

  attribute :unit_price do |object|
    object.price
  end

end
