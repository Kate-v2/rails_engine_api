

class ItemSerializer

  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :description

  attribute :unit_price do |object|
    object.price
  end

end
