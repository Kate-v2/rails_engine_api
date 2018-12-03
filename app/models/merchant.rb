
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



  # --- Total Revenue ---

  def self.total_revenue
    inv = successful_invoice_items
    revenue = inv.inject(0) { |sum, obj| sum += (obj.unit_price * obj.quantity) }
  end

  def self.successful_invoice_items
    InvoiceItem
    .joins(:transactions)
    .where('transactions.result = ?', 1)
  end

  # --- Rank by Revenue ---

  def self.most_revenue(qty)
    Merchant
    .successful_revenue
    .limit(qty)
  end

  def self.successful_invoices
    Merchant
    .joins(:transactions)
    .where('transactions.result = ?', 1)
    .group('invoices.id, transactions.invoice_id')
  end

  def self.successful_revenue
    Merchant
    .successful_invoices
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoice_items)
    .group('invoices.id, invoice_items.invoice_id')
    .group('merchants.id, invoices.merchant_id')
    .order('revenue DESC')
  end


end
