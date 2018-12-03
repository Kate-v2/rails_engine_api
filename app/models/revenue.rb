require "conversion"

class Revenue

  attr_reader :price, :id

  def initialize(revenue)
    @id = 1
    @revenue = revenue
  end

  def price
    ConversionTool.convert_to_currency(@revenue)
  end



end
