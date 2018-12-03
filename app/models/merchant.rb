
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

  # --- Most sold items ---

  def self.most_items
    Merchant
    .select('merchants.*, SUM(invoice_items.quantity) AS sum')
    .joins(:invoice_items)
    .group('merchants.id, invoices.id')
    .order('sum DESC, invoices.created_at DESC')
    .first
  end



  # --- Pending Customers ---

  def self.pending_customers(merch_id)
    Customer
    .having('SUM( COALESCE( transactions.result, 0) ) = 0')
    .left_outer_joins(:transactions)
    .group('customers.id, invoices.customer_id')
    .where('invoices.merchant_id = ?', merch_id)
  end


  # --- Favorite Customer ---

  def self.favorite_customer(merch_id)
    customer_successful_invoices
    .where('invoices.merchant_id = ?', merch_id)
    .select('customers.*, SUM(transactions.result) AS count')
    .group('customers.id, invoices.customer_id')
    .order('count DESC')
    .first
  end

  def self.customer_successful_invoices
    Customer
    .joins(:transactions)
    .where('transactions.result = ?', 1)
  end

  # --- Single Revenue ---

  def self.revenue(merch_id)
    inv = successful_invoice_items.where('invoices.merchant_id = ?', merch_id)
    revenue = inv.inject(0) { |sum, obj| sum += (obj.unit_price * obj.quantity) }
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
