
class Transaction < ApplicationRecord

  belongs_to :invoice

  has_one :merchant, through: :invoice
  has_one :customer, through: :invoice
  # belongs_to :merchant, through: :invoice
  # belongs_to :customer, through: :invoice


  enum result: [:failed, :success]

end
