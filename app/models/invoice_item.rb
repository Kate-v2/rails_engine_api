require "conversion"


class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price

  belongs_to :item
  belongs_to :invoice

  has_one :customer, through: :invoice
  has_one :merchant, through: :invoice

  has_many :transactions, through: :invoice

  # belongs_to :customer, through: :invoice
  # belongs_to :merchant, through: :invoice
  # TO DO -- look into delegate
  # TO DO -- look into has_one


  # has_many :transactions, through: :invoice

  def price
    ConversionTool.convert_to_currency(self.unit_price)
  end

  # --- Filter ---

  def self.name_is(name)
    InvoiceItem
    .joins(:item)
    .where('LOWER(items.name) = ?', name.downcase)
  end


end
