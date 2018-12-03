
class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  has_many :invoice_items, through: :invoices
  has_many :transactions,  through: :invoices
  has_many :customers,     through: :invoices

  def self.name_is(name)
    where('LOWER(name) = ?', name.downcase)
  end


end
