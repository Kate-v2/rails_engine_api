
class Item < ApplicationRecord

  belongs_to :merchant

  has_many :invoice_items

  # has_many :invoices, through: :invoice_items, as: :sale_orders

  # IF we need these
  # Alias them to distinguish path
  # has_many :invoices, through: :invoice_items
  # has_many :invoices, through: :merchants


end
