
class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :result

  belongs_to :invoice

  has_one :merchant, through: :invoice
  has_one :customer, through: :invoice

  has_many :invoice_items, through: :invoice
  # belongs_to :merchant, through: :invoice
  # belongs_to :customer, through: :invoice


  enum result: [:failed, :success]

end
