
class InvoiceItem < ApplicationRecord

  belongs_to :item
  belongs_to :invoice

  has_one :customer, through: :invoice
  has_one :merchant, through: :invoice

  # belongs_to :customer, through: :invoice
  # belongs_to :merchant, through: :invoice
  # TO DO -- look into delegate
  # TO DO -- look into has_one


  # has_many :transactions, through: :invoice

end
