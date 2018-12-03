
class Customer < ApplicationRecord

  validates_presence_of :first_name, :last_name

  has_many :invoices
  has_many :transactions, through: :invoices


  # --- Filter ---

  def self.first_name_is(name)
    where('LOWER(first_name) LIKE ?', name.downcase)
  end

  def self.last_name_is(name)
    where('LOWER(last_name) LIKE ?', name.downcase)
  end

end
