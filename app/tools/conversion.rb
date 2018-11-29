
class ConversionTool

  def self.convert_to_currency(value)
    (value.to_f / 100).round(2)
  end

end
