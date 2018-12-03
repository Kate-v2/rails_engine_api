require "conversion"

class RevenueSerializer

  include FastJsonapi::ObjectSerializer

  attribute :revenue do |object|
    object.price
  end

end
